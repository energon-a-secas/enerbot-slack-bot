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

# Validates origin and permissions over request

BOT_ADMINS = ENV['SLACK_USERS']
BOT_CHANNELS = ENV['SLACK_CHANNELS']
BOT_ICON = ENV['SLACK_ICON']
BOT_NAME = ENV['SLACK_NAME']
ADM_BAN = 'HALL OF SHAME'.freeze
ADM_LOG = '#bot_monitoring'.freeze
ADM_REGISTRY = 'HALL OF SHAME'.freeze

# Future wave Gem
class Enerbot
  attr_reader :token, :channel
  extend Admin
  extend Registry

  def initialize(token: '', channel: '')
    @bot_token = token
    @bot_channel = channel

    # Slack Token configure
    Slack.configure do |config|
      config.token = @bot_token
      config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
    end

    # Client initialization
    client = Slack::RealTime::Client.new

    client.on :hello do
      Enerbot.message(@bot_channel, 'Beginning LERN sequence')
    end

    # Listen to new messages
    client.on :message do |data|
      chan = data.channel
      text = data.text

      Enerbot.save(data)

      case text
      when /^enerbot/i then
        client.typing channel: chan
        Reply.new(data, text)
      when /^enersay/ then
        Reply.new(data, text)
      when /^enershut/ then
        Reply.new(data, text)
      when /^enerban/ then
        Enerbot.ban(data)
      when /^enerest/ then
        Enerbot.reset
      end
    end

    client.start!
  end

  def self.message(data, text, attach = '')
    puts data
    thread = data.ts if data.to_s.include?('thread_ts')

    find = if attach != ''
             json_file = File.read("./Info/#{text}")
             text = ':energon_enterprise:'
             JSON.parse(json_file)[attach]
           else
             []
           end

    channel = if data.respond_to? :channel
                data.channel
              else
                data
              end

    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: channel,
                                       text: text,
                                       icon_url: BOT_ICON,
                                       username: BOT_NAME,
                                       thread_ts: thread,
                                       attachments: find
  end

  def self.say(text)
    if (match = text.match(/enersay (\<[#@])?((.*)\|)?(.*?)(\>)? (.*?)$/i))
      [match.captures[2] || match.captures[3], match.captures[5]]
    else
      ['#bots', 'Meh']
    end
  end
end

Enerbot.new(token: '', channel: '')
