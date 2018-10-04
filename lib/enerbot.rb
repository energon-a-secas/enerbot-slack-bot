module Fly
  def self.message(data, text, icon, username)
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data.channel, text: text, icon_emoji: icon, username: username
  end
end

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
        when 'enerbot hola' then
          Fly.message(data, '¡Hola!', ':black_square:', 'ENERBOT')
        when /enerbot como va/ then
          Fly.message(data, 'Trabajo muy duro, como un esclavo... :musical_note:', ':black_square:', 'ENERBOT')
        when /enerbot un consejo/, /enerbot una pregunta/ then
          Fly.message(data, Quote.advice, ':black_square:', 'ENERBOT')
        when /enerbot beneficio/ then
          Fly.message(data, Quote.benefit, ':black_square:', 'ENERBOT')
        when 'enerbot las reglas', 'enerbot da rules', /enerbot the rules/ then
          Fly.message(data, Info.rules, ':black_square:', 'ENERBOT')
        when 'enerbot cuando pagan?'then
          Fly.message(data, Time_to.gardel, ':black_square:', 'ENERBOT')
        when 'enerbot cuanto para el 18'then
          Fly.message(data, Time_to.september, ':black_square:', 'ENERBOT')
        end
      else
        case data.text
        when /enerbot/ then
          Fly.message(data, Quote.advice, ':black_square:', 'ENERBOT')
        end
      end
    end
    client.start!
  end
end

