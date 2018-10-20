require 'slack-ruby-client'
require './Scripts/date'
require './Scripts/info'
require './Scripts/quote'

BOT_ICON=':energon:'
BOT_NAME='ENERBOT'

module Resp
  def self.message(data, text)
    puts data
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data.channel,
                                       text: text,
                                       icon_emoji: BOT_ICON,
                                       username: BOT_NAME
  end

  def self.response(data, path, attachments)
    puts data
    read_file = File.read("./Info/#{path}")
    ex_json = JSON.parse(read_file)
    attachments = ex_json[attachments]
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage as_user: true,
                                       channel: data.channel,
                                       text: 'Revisando mi BD :buffer:',
                                       icon_emoji: BOT_ICON,
                                       username: BOT_NAME,
                                       attachments: attachments
  end

  def self.write(chan, text)
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: chan,
                                       text: text,
                                       icon_emoji: BOT_ICON,
                                       username: BOT_NAME
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
  bot_admin = ENV['SLACK_USERS']
  bot_channel = ENV['SLACK_CHANNELS']

  if bot_channel.include? data.channel
    case data.text
    when /^enerbot\s(ayuda|help)$/i then
      Resp.message(data, Info.help)
    when /^enerbot hola/i then
      Resp.message(data, '¡Hola!')
    when /^enerbot\s(.*)\s(va|estas)$/i then
      Resp.message(data, Quote.status)
    when /^enerbot\s(.*)\s(consejo|pregunta)(.*?)/i then
      Resp.message(data, Quote.advice)
    when /^enerbot(.*)beneficio/i then
      Resp.message(data, Quote.benefit)
    when /^enerbot(.*)pack/i then
      Resp.message(data, Info.pack)
    when /^enerbot\s(.*)\s(rules|reglas)$/i then
      Resp.message(data, Info.rules)
    when /^enerbot cu[aá]ndo pagan?/i then
      Resp.message(data, Time_to.gardel)
    when /^enerbot cu[aá]nto para el 18?/i then
      Resp.message(data, Time_to.september)
    when /^enerbot info/i then
      if data.text.include? 'How'
        Resp.response(data, 'example.json', 'attachments')
      elsif data.text.include? 'enerconf talks'
        Resp.response(data, 'enerconf.json', 'talks')
      else
        Resp.response(data, 'enerconf.json', 'attachments')
      end
    when /^enerbot di/ then
      if bot_admin.include? data.user
        text = data.text.to_s.split(/\benerbot di \b/) * ''
        Resp.write('C3W4PHU7K', text)
      end
    when 'self-destruct' then
      if bot_admin.include? data.user
        Resp.message(data, 'Bye')
        abort('bye')
      else
        Resp.message(data, 'Meh')
      end
    end
  else
    case data.text
    when /enerbot/ then
      Resp.message(data, Quote.advice)
    end
  end
end

client.start!