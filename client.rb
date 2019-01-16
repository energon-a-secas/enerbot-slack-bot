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

# Class that evaluates if your worthy of calling the bot
class AccessEval
  $bot_icon = ENV['SLACK_ICON']
  $bot_name = ENV['SLACK_NAME']
  $bot_token = ENV['SLACK_API_TOKEN']
  $bot_users = ENV['SLACK_USERS']
  $bot_channels = ENV['SLACK_CHANNELS']
  $bot_log = ENV['SLACK_LOG_CHANNEL']
  $thread = '>>>*Thread registry:*'

  # Send message to channel
  def self.chan(data)
    user = data.user
    chan = data.channel

    Send.write($bot_log, Quote.alert(user, chan)) unless $bot_channels.include? chan
    Case.bot(data)
  end

  # Kill current session
  def self.kill(user, text)
    if !$bot_users.include? user
      Send.write($bot_log, Quote.alert(user, text))
    else
      Send.message(AccessEval, Case.kill(text)) && abort('bye')
    end
  end

  # Make a custom write
  def self.say(user, text)
    chan, msg = if !$bot_users.include?(user)
                  [$bot_log, Quote.alert(user, text)]
                elsif (match = text.match(/enersay (\<[#$])?((.*)\|)?(.*?)(\>)? (\d*.\d*|null) (.*?)$/i))
                  thread = if match.captures[5] != 'null'
                             match.captures[5]
                           else
                             ''
                           end
                  [match.captures[2] || match.captures[3], match.captures[6]]
                else
                  [$bot_log, "Please <$#{user}> learn to use enersay"]
                end
    Send.write(chan, msg, thread)
  end

  def self.thread(info)
    Send.write(AccessEval.channel, info.to_s)
  end

  def self.channel
    '#bots'
  end
end

# Slack Token configure
Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

# Client initialization and first message
client = Slack::RealTime::Client.new
client.on :hello do
  Send.message(AccessEval, 'Beginning LERN sequence')
end

# Endless loop of cases
client.on :message do |data|
  user = data.user
  chan = data.channel
  text = data.text
  thread = data.thread_ts
  registry = $thread

  registry << "\n*Channel:* #{chan}, *Thread:* #{thread}, *User:* <$#{user}>, *Text:* #{text}" unless thread.nil? && !text.to_s.include?('enerbot')

  # Initialization of the big case based on the first word
  case text
  when /^enerbot/i then
    client.typing channel: data.channel
    AccessEval.chan(data)
  when /^enersay/ then
    AccessEval.say(user, text)
  when /^enershut/ then
    AccessEval.kill(user, text)
  when /^enerssh/ then
    AccessEval.thread(registry)
  end
end

client.start!
