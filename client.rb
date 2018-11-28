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
require './scripts/security_check'
require './scripts/wikipedia'
require './scripts/celery'
require './scripts/lingo'
require './scripts/stock'
require './scripts/qr'
require './scripts/flight'
require './scripts/weather'
require './scripts/cves'
require './scripts/canitrot'
require './client_helper'
require './core'

# Class
class BotValue
  BOT_ICON = ':energon:'.freeze
  BOT_NAME = 'ENERBOT'.freeze
  BOT_ADMINS = ENV['SLACK_USERS']
  BOT_CHANNELS = ENV['SLACK_CHANNELS']
  BOT_TOKEN = ENV['SLACK_API_TOKEN']

  def self.channel
    '#bots'
  end
end

Slack.configure do |config|
  config.token = BotValue::BOT_TOKEN
  config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  Resp.message(LERN, 'Beginning LERN sequence')
end

client.on :message do |data|
  text = data.text
  case text
  when /^enerbot/i then
    if !BotValue::BOT_CHANNELS.include? data.channel
      Resp.message(BotValue, Unauthorized.chan(data))
    else
      Case.bot(data)
    end
  when /^enersay/ then
    Case.say(data)
  when /^enerssh/ then
    Resp.message(data, Remote.ssh(data))
  when /(enershut|お前もう死んでいる)/ then
    kill_type = case text
                when 'enershut'
                  System.kill
                when 'お前もう死んでいる'
                  Quote.japanese
                end
    if BotValue::BOT_ADMINS.include? data.user
      Resp.message(data, kill_type) && abort('bye')
    else
      Resp.message(BotValue, Unauthorized.kill(data))
    end
  end
end
client.start!
