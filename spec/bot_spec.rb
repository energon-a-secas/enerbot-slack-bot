require 'slack-ruby-client'
require './scripts/quote'
require './scripts/system'
require './scripts/date'
require './core'

class BotValue
  BOT_ICON = ':energon:'.freeze
  BOT_NAME = 'ENERBOT'.freeze
  BOT_TOKEN = ENV['SLACK_API_TOKEN']
  BOT_PHRASES = ['enerbot hola',
                 'enerbot pregunta',
                 'enerbot beneficio',
                 'enerbot cuándo pagan',
                 'enerbot password',
                 'enerbot cuanto para el 18?'].freeze
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
      config.token = BotValue::BOT_TOKEN
    end
  end

  context 'when client is initialized' do
    it 'send messages to #bots' do
      BotValue::BOT_PHRASES.each do |i|
        MESSAGE = i
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
