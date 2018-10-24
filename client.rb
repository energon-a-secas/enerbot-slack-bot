require 'slack-ruby-client'
require './scripts/date'
require './scripts/system'
require './scripts/quote'
require './scripts/ssh'
require './scripts/pass'
require './scripts/tc'
require './scripts/2fa'
require './core'

class BotValue
  BOT_ICON = ':energon:'.freeze
  BOT_NAME = 'ENERBOT'.freeze
  BOT_ADMINS = ENV['SLACK_USERS']
  BOT_CHANNELS = ENV['SLACK_CHANNELS']
  BOT_TOKEN = ENV['SLACK_API_TOKEN']
  HOST_SSH = ENV['HOST_SSH']
  USER_SSH = ENV['USER_SSH']
  PASS_SSH = ENV['PASS_SSH']
end

Slack.configure do |config|
  config.token = BotValue::BOT_TOKEN
  config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "Welcome '#{client.self.name}' to the '#{client.team.name}' team"
end

client.on :message do |data|
  if BotValue::BOT_CHANNELS.include? data.channel
    case data.text
    when /^enerbot/i then
      Case.bot(data)
    when /^enersay/ then
      Case.say(data) if BotValue::BOT_ADMINS.include? data.user
    when /^enerssh/ then
      text = Remote.ssh(data)
      Resp.message(data, text) if BotValue::BOT_ADMINS.include? data.user
    when /^enershut/ then
      Resp.message(data, 'Bye') && abort('bye') if BotValue::BOT_ADMINS.include? data.user
    end
  end
end

client.start!
