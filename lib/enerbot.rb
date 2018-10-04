require 'slack-ruby-client'

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
  if 'DBDH58JJU'.include? data.channel
    case data.text
    when 'enerbotv hola' then
      send_message(data, '¡Hola!', ':black_square:', 'ENERBOT')
    when /enerbotv como va/ then
      send_message(data, 'Trabajo muy duro, como un esclavo... :musical_note:', ':black_square:', 'ENERBOT')
    when 'self-destruct' then
      send_message(data, 'Adios mundo cruel', ':bomb:', 'ENERBOT')
      abort('Bye')
    end
  else
    case data.text
    when /enerbotv como va/ then
      send_message(data, 'Trabajo muy duro, como un esclavo... :musical_note:', ':black_square:', 'ENERBOT')

    end
  end
end

client.start!