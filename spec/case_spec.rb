require 'slack-ruby-client'
require './Scripts/quote'
require './Scripts/system'
require './Scripts/date'
require './core'

context 'Parse' do
  specify 'avoid' do

    BOT_ICON = ':energon:'.freeze
    BOT_NAME = 'ENERTEST'.freeze
    BOT_TOKEN = ENV['SLACK_API_TOKEN']

    Slack.configure do |config|
      config.token = BOT_TOKEN
      config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
    end

    module Fake
      def self.text
        MESSAGE
      end
      def self.channel
        '#bots'
      end
    end

    phrases = ['enerbot hola',
           'enerbot pregunta',
           'enerbot beneficio',
           'enerbot pack']
    phrases.each do |i|
      MESSAGE = i
      Case.bot(Fake)
    end

  end
end