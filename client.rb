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
require './core'

# Variables and other herbs
class AccessEval
  BOT_ICON = ':energon:'.freeze
  BOT_NAME = 'ENERBOT'.freeze
  BOT_ADMINS = ENV['SLACK_USERS']
  BOT_CHANNELS = ENV['SLACK_CHANNELS']
  BOT_TOKEN = ENV['SLACK_API_TOKEN']

  def self.chan(data)
    chan = data.channel
    if !AccessEval::BOT_CHANNELS.include? chan
      Resp.message(LERN, ":newalert: <@#{data.user}> almost make me work on <##{chan}>!")
    else
      Case.bot(data)
    end
  end

  def self.kill(data)
    user = data.user
    if !AccessEval::BOT_ADMINS.include? user
      Resp.message(LERN, ":newalert: <@#{user}> tried to kill me!")
    else
      Resp.message(data, Case.kill(data)) && abort('bye')
    end
  end

  # Just for the sake of messaging on start
  def self.channel
    '#bots'
  end
end

# LERN TECH
class LERN
  def self.channel
    '#bots'
  end
end

Slack.configure do |config|
  config.token = AccessEval::BOT_TOKEN
  config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::RealTime::Client.new

client.on :hello do
  Resp.message(AccessEval, 'Beginning LERN sequence')
end

client.on :message do |data|
  text = data.text
  case text
  when /^enerbot/i then
    AccessEval.chan(data)
  when /^enersay/ then
    Case.say(data)
  when /^enerssh/ then
    Resp.message(data, Remote.ssh(data))
  when /(enershut|お前もう死んでいる)/ then
    AccessEval.kill(data)
  end
end
client.start!
