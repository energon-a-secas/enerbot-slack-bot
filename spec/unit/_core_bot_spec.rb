require 'slack-ruby-client'
require './scripts/quote'
require './scripts/system'
require './scripts/date'
require './scripts/pass'
require './scripts/tc'
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
          'enerbot cuanto para el 18?'
      ].each do |text|
        MESSAGE = text
        Case.bot(Fake)
      end
    end

    it 'send credit cards to #bots' do
      [
          'enerbot tc bankcard',
          'enerbot tc mastercard',
          'enerbot tc solo',
          'enerbot tc visa',
          'enerbot tc meh',
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
