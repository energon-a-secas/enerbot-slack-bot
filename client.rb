require 'slack-ruby-client'
require './acl.rb'
require './Scripts/ssh'
require './Scripts/random'
require './Scripts/rules'
require './Scripts/18.rb'
require './Scripts/gardel.rb'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
end

def send_message(data, text, icon, username)
  client = Slack::RealTime::Client.new
  client.web_client.chat_postMessage channel: data.channel, text: text, icon_emoji: icon, username: username
end

def show_output(data, info, icon)
  client = Slack::RealTime::Client.new
  client.web_client.chat_postMessage as_user: true, channel: data.channel, text: "Oki <@#{data.user}>!", attachments: [{ fallback: 'Sup', title: 'Output', text: info.to_s }], icon_emoji: icon
end

client.on :message do |data|
  puts data
  case data.text
  when 'enerbot hola' then
    send_message(data, '¡Hola!', ':black_square:', 'ENERBOT')
  when /enerbot como va/ then
    send_message(data, 'Trabajo muy duro, como un esclavo... :musical_note:', ':black_square:', 'ENERBOT')
  when /enerbot un consejo/, /enerbot una pregunta/ then
    send_message(data, random_advice, ':black_square:', 'ENERBOT')
  when /enerbot beneficio/ then
    send_message(data, random_benefit, ':black_square:', 'ENERBOT')
  when 'enerbot las reglas', 'enerbot da rules', /enerbot the rules/ then
    send_message(data, rules_energon, ':black_square:', 'ENERBOT')
  when 'enerbot pack'then
    send_message(data, pack_energon, ':black_square:', 'ENERBOT')
  when 'enerbot cuando pagan?'then
    send_message(data, cuando_pagan, ':black_square:', 'ENERBOT')
  when 'enerbot cuanto para el 18'then
    send_message(data, cuando_sept, ':black_square:', 'ENERBOT')
  when /^bot/ then
    control(data.text.to_s, data.user.to_s, data.channel.to_s)
    if !$output.nil?
      ssh = show($output).to_s
      show_output(data, ssh, ':skull:')
    else
      send_message(data, "You don't have power here <@#{data.user}>!", ':male_mage:', 'Gandalf')
    end
  when 'self-destruct' then
    send_message(data, 'Adios mundo cruel', ':bomb:', 'ENERBOT')
    abort('Bye')
end
end

client.start!
