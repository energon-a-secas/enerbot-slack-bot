module Slack
  require 'slack-ruby-client'
  require 'LERN/date'
  require 'LERN/info'
  require 'LERN/quote'

  def self.run
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
      if 'DBDH58JJU'.include? data.channel
        case data.text
        when 'enerbotv hola' then
          client.web_client.chat_postMessage channel: data.channel, text: '¡Hola!', icon_emoji: ':black_square:', username: 'ENERBOT'
        when /enerbotb como va/ then
          client.web_client.chat_postMessage channel: data.channel, text: 'Trabajo muy duro, como un esclavo... :musical_note:', icon_emoji: ':black_square:', username: 'ENERBOT'
        when /enerbotb un consejo/, /enerbot una pregunta/ then
          client.web_client.chat_postMessage channel: data.channel, text: Quote.advice, icon_emoji: ':black_square:', username: 'ENERBOT'
        when 'enerbot cuando pagan?'then
          client.web_client.chat_postMessage channel: data.channel, text: Time_to.gardel, icon_emoji: ':black_square:', username: 'ENERBOT'
        when 'enerbot las reglas', 'enerbot da rules', /enerbot the rules/ then
          client.web_client.chat_postMessage channel: data.channel, text: Info.rules, icon_emoji: ':black_square:', username: 'ENERBOT'
        when 'self-destruct' then
          abort('Bye')
        end
      else
        case data.text
        when /enerbotv como va/ then
          client.web_client.chat_postMessage channel: data.channel, text: Quote.advice, icon_emoji: ':black_square:', username: 'ENERBOT'

        end
      end
    end
    client.start!
  end
end

