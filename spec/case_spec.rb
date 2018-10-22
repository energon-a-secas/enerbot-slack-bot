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
                 'enerbot cuando pagan?',
                 'enerbot cuanto para el 18?'].freeze
  BOT_CUSTOM = ['enersay123',
                'enersay 123',
                'enersayasd',
                'enersay asd',
                'enersay:bam:',
                'enersay :bam:',
                'enersay$$'].freeze
end

module Fake
  def self.text
    MESSAGE
  end

  def self.channel
    '#bots'
  end
end

Slack.configure do |config|
  config.token = BotValue::BOT_TOKEN
  config.raise 'Missing token' unless config.token
end

context 'Parse' do
  specify 'enerfun' do

    BotValue::BOT_PHRASES.each do |i|
      MESSAGE = i
      Case.bot(Fake)
    end
  end
end

# context 'Send' do
#   specify 'message' do
#     BotValue::BOT_CUSTOM.each do |i|
#       MESSAGE = i
#     Case.say(Fake)
#     end
#   end
# end
