require 'slack-ruby-client'
require './core'

class BotValue
  BOT_ICON = ':energon:'.freeze
  BOT_NAME = 'ENERTEST'.freeze
  BOT_ADMINS = 'user'.freeze
end

# Acts like a incoming message from Slack
module Fake
  def self.text
    MESSAGE
  end

  def self.user
    'user'
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
        'enersay #bots hola',
        'enersay #bots enerbot hola',
        'enersay #bots !·%%',
        'enersay #bots 123 123 test testing  testeando',
        'enersay #bots testing:energon:',
        'enersay #bots :energon::energon::energon:',
        'enersay #bots :newalert: testing :energon:'
      ].each do |text|
        MESSAGE = text
        Case.say(Fake)
      end
    end
  end

  # context 'when client is not initialized' do
  #   it 'fails badly' do
  #     #TODO
  #   end
  # end
end
