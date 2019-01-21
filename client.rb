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
require './system'

# Class that evaluates if your worthy of calling the bo
class AccessEval
  BOT_ICON = ENV['SLACK_ICON']
  BOT_NAME = ENV['SLACK_NAME']
  BOT_TOKEN = ENV['SLACK_API_TOKEN']
  BOT_LOG = ENV['SLACK_LOG_CHANNEL']
  THREAD_REGISTRY = ''

  # Return threads id number
  def self.thread(info)
    Resp.write(BOT_LOG, info.to_s)
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
  Resp.message(AccessEval::BOT_LOG, 'Beginning LERN sequence')
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
    client.typing channel: chan
    Reply.new(data, text)
  when /^enersay/ then
    Reply.new(data, text)
  when /^enerthread/ then
    AccessEval.say(user, text)
  when /^enershut/ then
    Reply.new(data, text)
  when /^enerssh/ then
    AccessEval.thread(registry)
  end
end
client.start!
