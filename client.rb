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
require './scripts/bronze'
require './scripts/macaulay'
require './scripts/haarp'
require './core'

# Variables and other herbs
class AccessEval
  BOT_ICON = ':enerbot:'.freeze
  BOT_NAME = 'ENERBOT'.freeze
  BOT_ADMINS = ENV['SLACK_USERS']
  BOT_CHANNELS = ENV['SLACK_CHANNELS']
  BOT_TOKEN = ENV['SLACK_API_TOKEN']
  BOT_LOG = ENV['SLACK_LOG_CHANNEL']

  def self.chan(data)
    chan = data.channel
    Resp.write(BOT_LOG, ":newalert: <@#{data.user}> is making me work on <##{chan}>!") unless AccessEval::BOT_CHANNELS.include? chan
    Case.bot(data)
  end

  def self.kill(data)
    user = data.user
    if !AccessEval::BOT_ADMINS.include? user
      Resp.write(BOT_LOG, ":newalert: <@#{user}> tried to kill me!")
    else
      Resp.message(data, Case.kill(data)) && abort('bye')
    end
  end

  def self.say(data)
    if !AccessEval::BOT_ADMINS.include?(data.user)
      Resp.write(BOT_LOG, ":newalert: <@#{data.user}> almost use a paid functionality!")
    else
      text = data.text.split
      mess = text[2..-1].join(' ')
      Resp.write(text[1].to_s, mess)
    end
  end

  # Just for the sake of messaging on start
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
  client.typing channel: data.channel
  text = data.text
  case text
  when /^enerbot/i then
    AccessEval.chan(data)
  when /^enersay/ then
    AccessEval.say(data)
  when /^enerssh/ then
    Resp.message(data, Remote.ssh(data))
  when /(enershut|お前もう死んでいる)/ then
    AccessEval.kill(data)
  end
end
client.start!
