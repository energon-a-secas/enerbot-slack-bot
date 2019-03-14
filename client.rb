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
    @channel, @ts = if data.respond_to? :channel
                      [data.channel, '']
                    else
                      check = data.match(/(.*):(\d*.\d*)/)
                      if check
                        [check[1], check[2]]
                      else
                        [data, '']
                      end
                    end
    @thread = if data.respond_to? :thread_ts
                data.ts
              elsif !@ts.empty?
                @ts
              end
  end
end

# The Magician
class Enerbot < EnerCheck
  extend Admin

  EnerSet.new
  @bot_icon = ENV['SLACK_ICON']
  @bot_name = ENV['SLACK_NAME']
  @client = Slack::RealTime::Client.new
  @web_client = Slack::Web::Client.new

  def self.listen
    client = @client

    client.on :message do |data|
      text = data.text

      Reply.new(data) if text =~ /^(ener[brs])/i
    end

    client.start!
  end

  def self.message(data, text, attach = '')
    p data

    target_check(data)
    find = attach_check(text, attach)

    if text =~ /(mcafee|partyenergon|homero)/
      reaction(text)
    else
      write(text, find)
    end
  end

  def reaction(text)
    @web_client.reactions_add channel: @channel,
                              name: text,
                              icon_url: @bot_icon,
                              username: @bot_name,
                              timestamp: @thread
  end

  def write(text, find = '')
    @client.web_client.chat_postMessage channel: @channel,
                                        text: text,
                                        icon_url: @bot_icon,
                                        username: @bot_name,
                                        thread_ts: @thread,
                                        attachments: find
  end
end

Enerbot.listen
