require 'slack-ruby-client'
require './scripts/date'
require './scripts/system'
require './scripts/quote'
require './scripts/ssh'
require './scripts/pass'
require './scripts/tc'
require './scripts/2fa'
require './scripts/random'
require './scripts/horoscopo'
require './scripts/lotery'
require './scripts/securityCheck'
require './scripts/wikipedia'
require './scripts/celery'
require './scripts/lingo'
require './scripts/stock'
require './scripts/qr'
require './scripts/flight'
require './scripts/weather'
require './core'

class BotValue
  BOT_ICON = ':energon:'.freeze
  BOT_NAME = 'ENERTEST'.freeze
end

# Acts like a incoming message from Slack
module Fake
  def self.text
    MESSAGE
  end

  def self.channel
    '#bots'
  end
end

describe '#bot' do
  before(:each) do
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
    end
  end

  context 'when client is initialized' do
    it 'send messages to #bots' do
      [
          'enerbot hola',
          'enerbot pregunta',
          'enerbot beneficio',
          'enerbot cuándo pagan',
          'enerbot password',
          'enerbot password sec',
          'enerbot 2fa asadasd',
          'enerbot random 1 2 3',
          'enerbot horoscopo piscis',
          'enerbot resultados kino',
          'enerbot valor accion energon',
          'enerbot qr hola',
          'enerbot vuelo LAN122',
          'enerbot clima',
          'enerbot cuanto para el 18?'
      ].each do |text|
        MESSAGE = text
        Case.bot(Fake)
      end
    end

    it 'send credit cards to #bots' do
      [
          'enerbot tc bankcard',
          'enerbot tc masterca'
      ].each do |text|
        MESSAGE = text
        Resp.message(Fake, Credit.gen(Fake))
      end
    end
  end

  # context 'when client is not initialized' do
  #   it 'fails badly' do
  #     #TODO
  #   end
  # end
end
