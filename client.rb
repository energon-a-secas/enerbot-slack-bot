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

  def self.chan(data)
    user = data.user
    chan = data.channel

    Resp.write(BOT_LOG, Quote.alert(user, chan)) unless BOT_CHANNELS.include? chan
    Case.bot(data)
  end

  def self.kill(data)
    user = data.user
    text = data.text

    if !BOT_ADMINS.include? user
      Resp.write(BOT_LOG, Quote.alert(user, text))
    else
      Resp.message(data, Case.kill(text)) && abort('bye')
    end
  end

  def self.say(data)
    user = data.user
    text = data.text.split

    chan, msg = if !BOT_ADMINS.include?(user)
                  [BOT_LOG, Quote.alert(user, text)]
                elsif (match = data.text.match(/enersay (\<[#@])?((.*)\|)?(.*?)(\>)? (\d{10}.\d{6}|null) (.*?)$/i))
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
  text = data.text
  case text
  when /^enerbot/i then
    client.typing channel: data.channel
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
