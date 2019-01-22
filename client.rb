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
require './scripts/dice'
require './core'

# Class that evaluates if your worthy of calling the bo
class AccessEval
  BOT_ICON = ENV['SLACK_ICON']
  BOT_NAME = ENV['SLACK_NAME']
  BOT_ADMINS = ENV['SLACK_USERS']
  BOT_CHANNELS = ENV['SLACK_CHANNELS']
  BOT_TOKEN = ENV['SLACK_API_TOKEN']
  BOT_LOG = ENV['SLACK_LOG_CHANNEL']
  THREAD_REGISTRY = '>>>*Thread registry:*'

  # Send message to channel
  def self.chan(data)
    user = data.user
    chan = data.channel

    Resp.write(BOT_LOG, Quote.alert(user, chan)) unless BOT_CHANNELS.include? chan
    Case.bot(data)
  end

  # Kill current session
  def self.kill(user, text)
    if !BOT_ADMINS.include? user
      Resp.write(BOT_LOG, Quote.alert(user, text))
    else
      Resp.message(AccessEval, Case.kill(text)) && abort('bye')
    end
  end

  # Make a custom write
  def self.say(user, text)
    chan, msg = if !BOT_ADMINS.include?(user)
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

  # Return threads id number
  def self.thread(info)
    Resp.write(AccessEval.channel, info.to_s)
  end

  def self.channel
    '#bots'
  end
end

# Slack Token configure
Slack.configure do |config|
  config.token = AccessEval::BOT_TOKEN
  config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

# Client initialization and first message
client = Slack::RealTime::Client.new
client.on :hello do
  Resp.message(AccessEval, 'Beginning LERN sequence')
end

# Endless loop of cases
client.on :message do |data|
  user = data.user
  chan = data.channel
  text = data.text
  thread = data.thread_ts
  registry = AccessEval::THREAD_REGISTRY

  registry << "\n*Channel:* #{chan}, *Thread:* #{thread}, *User:* <@#{user}>, *Text:* #{text}" unless thread.nil? && user != 'enerbot' && !text.to_s.include?('enerbot')

  # Initialization of the big case based on the first word
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
  end
end
client.start!
