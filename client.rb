require 'slack-ruby-client'
require './Scripts/date'
require './Scripts/info'
require './Scripts/quote'
require './Scripts/ssh'
require './functions'

BOT_ICON = ':energon:'.freeze
BOT_NAME = 'ENERBOT'.freeze
BOT_ADMINS = ENV['SLACK_USERS']
BOT_CHANNELS = ENV['SLACK_CHANNELS']
BOT_TOKEN = ENV['SLACK_API_TOKEN']
HOST_SSH = ENV['HOST_SSH']
USER_SSH = ENV['USER_SSH']
PASS_SSH = ENV['PASS_SSH']

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
      Case.say(data) if BOT_ADMINS.include? data.user
    when /^enerssh/ then
      text = Remote.ssh(data)
      Resp.message(data, text) if BOT_ADMINS.include? data.user
    end
  end
end

client.start!
