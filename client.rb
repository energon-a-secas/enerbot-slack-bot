require 'slack-ruby-client'
require './core'
require './system'

# Slack Configuration
class EnerSet
  def initialize
    @bot_token = ENV['SLACK_API_TOKEN']
    @bot_channel = ENV['SLACK_LOG_BOT']

    File.new('black_list.log', 'w')

    # Slack Token configure
    Slack.configure do |config|
      config.token = @bot_token
      config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
    end
  end
end

# Spell check
class EnerCheck

  def self.attach_check(text, attach)
    if attach != ''
      json_file = File.read("./Info/#{text}")
      JSON.parse(json_file)[attach]
    else
      []
    end
  end

  def self.target_check(data)
    if data.respond_to? :channel
      [data.channel, '']
    else
      check = data.match(/(.*):(\d*.\d*)/)
      if check
        [check[1], check[2]]
      else
        [data, '']
      end
    end
  end

  def self.thread_check(data, ts)
    if data.respond_to? :thread_ts
      data.ts
    elsif !ts.empty?
      ts
    end
  end
end

# The Magician
class Enerbot < EnerCheck
  extend Admin

  EnerSet.new
  @bot_icon = ENV['SLACK_ICON']
  @bot_name = ENV['SLACK_NAME']
  @real_client = Slack::RealTime::Client.new
  @web_client = Slack::Web::Client.new

  def self.think
    client = @real_client

    client.on :message do |data|
      chan = data.channel
      text = data.text

      case text
      when /^(ener[brs])/i then
        client.typing channel: chan
        Reply.new(data)
      end
    end

    client.start!
  end

  def self.message(data, text, attach = '')
    p data

    channel, ts = Enerbot.target_check(data)
    thread = Enerbot.thread_check(data, ts)
    find = Enerbot.attach_check(text, attach)

    if text =~ /(mcafee|partyenergon|homero)/
      @web_client.reactions_add channel: channel,
                                name: text,
                                icon_url: @bot_icon,
                                username: @bot_name,
                                timestamp: thread

    else
      @real_client.web_client.chat_postMessage channel: channel,
                                               text: text,
                                               icon_url: @bot_icon,
                                               username: @bot_name,
                                               thread_ts: thread,
                                               attachments: find

    end
  end
end

Enerbot.think
