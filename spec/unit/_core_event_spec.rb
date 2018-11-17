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
          'enerbot fuq',
          'enerbot faq',
          'enerbot info eventos',
          'enerbot info talks',
          'enerbot info tips',
          'enerbot info enerlive',
          'enerbot info institute',
          'enerbot info contest general_info',
          'enerbot info SDSOS',
          'enerbot info diseña'
      ].each do |text|
        MESSAGE = text
        Case.bot(Fake)
      end
    end

  end

  # context 'when client is not initialized' do
  #   it 'fails badly' do
  #     #TODO
  #   end
  # end
end
