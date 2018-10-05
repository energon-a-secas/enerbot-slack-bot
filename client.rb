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
  bot_icon = ':black_square:'
  bot_name = 'ENERBOT'
  if 'DBDH58JJU'.include? data.channel
    case data.text
    when 'enerbot hola' then
      Fly.message(data, '¡Hola!', bot_icon, bot_name)
    when /enerbot como va/ then
      Fly.message(data, Quote.status, bot_icon, bot_name)
    when /enerbot un consejo/, /enerbot una pregunta/ then
      Fly.message(data, Quote.advice, bot_icon, bot_name)
    when /enerbot beneficio/ then
      Fly.message(data, Quote.benefit, bot_icon, bot_name)
    when 'enerbot las reglas', 'enerbot da rules', /enerbot the rules/ then
      Fly.message(data, Info.rules, bot_icon, bot_name)
    when 'enerbot cuando pagan?'then
      Fly.message(data, Time_to.gardel, bot_icon, bot_name)
    when 'enerbot cuanto para el 18'then
      Fly.message(data, Time_to.september, bot_icon, bot_name)
    end
  else
    case data.text
    when /enerbot/ then
      Fly.message(data, Quote.advice, bot_icon, bot_name)
    end
  end
end
client.start!