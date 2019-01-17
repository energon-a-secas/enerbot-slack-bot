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
require './scripts/flight'
require './scripts/weather'
require './scripts/cves'
require './scripts/canitrot'
require './scripts/bronze'
require './scripts/macaulay'
require './scripts/haarp'
require './scripts/secret_friend'
require './scripts/dns'
require './scripts/hibp'
require './scripts/fire'
require './scripts/acme'
require './scripts/chimuelo'
require './core'

# Variables and other herbs
class AccessEval
  BOT_ICON = ENV['SLACK_ICON']
  BOT_NAME = ENV['SLACK_NAME']
  BOT_ADMINS = ENV['SLACK_USERS']
  BOT_CHANNELS = ENV['SLACK_CHANNELS']
  BOT_TOKEN = ENV['SLACK_API_TOKEN']
  BOT_LOG = ENV['SLACK_LOG_CHANNEL']
  THREAD_REGISTRY = '>>>*Thread registry:*'
  BAN_REGISTRY = ''

  def self.chan(data)
    user = data.user
    chan = data.channel

    Resp.write(BOT_LOG, Quote.alert(user, chan)) unless BOT_CHANNELS.include? chan
    Case.bot(data) unless BAN_REGISTRY.include?(user)
  end

  def self.kill(user, text)
    if !BOT_ADMINS.include? user || BAN_REGISTRY.include?(user)
      Resp.write(BOT_LOG, Quote.alert(user, text))
    else
      Resp.message(AccessEval, Case.kill(text)) && abort('bye')
    end
  end

  def self.say(user, text)
    chan, msg = if !BOT_ADMINS.include?(user) || BAN_REGISTRY.include?(user)
                  [BOT_LOG, Quote.alert(user, text)]
                elsif (match = text.match(/enersay (\<[#@])?((.*)\|)?(.*?)(\>)? (\d*.\d*|null) (.*?)$/i))
                  thread = if match.captures[5] != 'null'
                             match.captures[5]
                           else
                             ''
                           end
                  [match.captures[2] || match.captures[3], match.captures[6]]
                else
                  [BOT_LOG, "Please <@#{user}> learn to use enersay"]
                end
    Resp.write(chan, msg, thread)
  end

  def self.thread(info)
    Resp.write(AccessEval.channel, info.to_s)
  end

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
  user = data.user
  chan = data.channel
  text = data.text
  thread = data.thread_ts
  registry = AccessEval::THREAD_REGISTRY
  ban_list = AccessEval::BAN_REGISTRY

  registry << "\n*Channel:* #{chan}, *Thread:* #{thread}, *User:* <@#{user}>, *Text:* #{text}" unless thread.nil? && !text.to_s.include?('enerbot')

  case text
  when /^enerbot/i then
    client.typing channel: data.channel
    AccessEval.chan(data)
  when /^enersay/ then
    AccessEval.say(user, text)
  when /^(enershut|お前もう死んでいる)/ then
    AccessEval.kill(user, text)
  when /^enerssh/ then
    AccessEval.thread(registry)
  when /enerban/ then
    ban_list << text unless !BOT_ADMINS.include? user
  end
end
client.start!
