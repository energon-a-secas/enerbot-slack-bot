require 'slack-ruby-client'
require './Scripts/date'
require './Scripts/info'
require './Scripts/quote'

module Fly
  def self.message(data, text, icon, username)
    puts data
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data.channel,
                                       text: text,
                                       icon_emoji: icon,
                                       username: username
  end

  def self.response(data, path, attachments, icon, username)
    puts data
    read_file = File.read("./Info/#{path}")
    ex_json = JSON.parse(read_file)
    attachments = ex_json[attachments]
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage as_user: true,
                                       channel: data.channel,
                                       text: 'Revisando mi BD',
                                       icon_emoji: icon,
                                       username: username,
                                       attachments: attachments
  end
end

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

client.on :message do |data|
  bot_icon = ':energon:'
  bot_name = 'ENERBOT'
  bot_admin = ENV['SLACK_USERS']
  bot_channel = ENV['SLACK_CHANNELS']

  if bot_channel.include? data.channel
    case data.text
    when /^enerbot\s(ayuda|help)$/i then
      Fly.message(data, Info.help, bot_icon, bot_name)
    when /^enerbot hola/i then
      Fly.message(data, '¡Hola!', bot_icon, bot_name)
    when /^enerbot\s(.*)\s(va|estas)$/i then
      Fly.message(data, Quote.status, bot_icon, bot_name)
    when /^enerbot\s(.*)\s(consejo|pregunta)(.*?)/i then
      Fly.message(data, Quote.advice, bot_icon, bot_name)
    when /^enerbot(.*)beneficio/i then
      Fly.message(data, Quote.benefit, bot_icon, bot_name)
    when /^enerbot(.*)pack/i then
      Fly.message(data, Info.pack, bot_icon, bot_name)
    when /^enerbot\s(.*)\s(rules|reglas)$/i then
      Fly.message(data, Info.rules, bot_icon, bot_name)
    when /^enerbot cu[aá]ndo pagan?/i then
      Fly.message(data, Time_to.gardel, bot_icon, bot_name)
    when /^enerbot cu[aá]nto para el 18?/i then
      Fly.message(data, Time_to.september, bot_icon, bot_name)
    when /^enerbot info/i then
      if data.text.include? 'How'
        Fly.response(data, 'example.json', 'attachments', bot_icon, bot_name)
      else
        Fly.response(data, 'enerconf.json', 'attachments', bot_icon, bot_name)
      end
    when 'self-destruct' then
      if bot_admin.include? data.user
        Fly.message(data, 'Bye', bot_icon, bot_name)
        abort('bye')
      else
        Fly.message(data, 'Meh', bot_icon, bot_name)
      end
    end
  else
    case data.text
    when /enerbot/ then
      Fly.message(data, Quote.advice, bot_icon, bot_name)
    end
  end
end

client.start!
