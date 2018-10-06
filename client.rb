require 'slack-ruby-client'
require './Scripts/date'
require './Scripts/info'
require './Scripts/quote'

module Fly
  def self.message(data, text, icon, username)
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data.channel, text: text, icon_emoji: icon, username: username
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
  puts data
  bot_icon = ':energon:'
  bot_name = 'ENERBOT'
  bot_admin = ENV['SLACK_USERS']
  bot_channel = ENV['SLACK_CHANNELS']

  if bot_channel.include? data.channel
    case data.text
    when /enerbot\s(ayuda|help)$/ then
      Fly.message(data, Info.help, bot_icon, bot_name)
    when 'enerbot hola' then
      Fly.message(data, '¡Hola!', bot_icon, bot_name)
    when /enerbot\s(.*)\s(va|estas)$/ then
      Fly.message(data, Quote.status, bot_icon, bot_name)
    when /enerbot\s(.*)\s(consejo|pregunta)(.*)?/ then
      Fly.message(data, Quote.advice, bot_icon, bot_name)
    when /enerbot un beneficio/ then
      Fly.message(data, Quote.benefit, bot_icon, bot_name)
    when /enerbot(.*)pack/ then
      Fly.message(data, Info.pack, bot_icon, bot_name)
    when /enerbot\s(.*)\s(rules|reglas)$/ then
      Fly.message(data, Info.rules, bot_icon, bot_name)
    when /enerbot cu[aá]ndo pagan?/ then
      Fly.message(data, Time_to.gardel, bot_icon, bot_name)
    when /enerbot cu[aá]nto para el 18?/ then
      Fly.message(data, Time_to.september, bot_icon, bot_name)
    when 'self-destruct' then
      if bot_admin.include? data.user
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
