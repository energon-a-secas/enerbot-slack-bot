require 'slack-ruby-client'
require './Scripts/date'
require './Scripts/info'
require './Scripts/quote'
require './functions'

BOT_ICON = ':energon:'
BOT_NAME = 'ENERBOT'
BOT_ADMINS = ENV['SLACK_USERS']
BOT_CHANNELS = ENV['SLACK_CHANNELS']
BOT_TOKEN = ENV['SLACK_TOKEN']

Slack.configure do |config|
  config.token = BOT_TOKEN
  config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Welcome '#{client.self.name}' to the '#{client.team.name}' team"
end

client.on :message do |data|

  if BOT_CHANNELS.include? data.channel
    case data.text
    when /^enerbot/i then
      Case.bot(data)
    when /^enersay/ then
      if BOT_ADMINS.include? data.user
        Case.say(data)
      else
        Resp.message(data, 'Meh')
      end
    end
  end
end

client.start!