require 'slack-ruby-client'
require './message'
require './core'
require './system'

BOT_TOKEN = ENV['SLACK_API_TOKEN']
BOT_CHANNEL = ENV['SLACK_LOG_BOT']
BOT_CASE = /^(ener[abrs])/i

# Checks the text for selecting the correct method
module PeyosRegex
  def attach_check(text, attach)
    if attach != ''
      json_file = File.read("./Info/#{text}")
      JSON.parse(json_file)[attach]
    else
      []
    end
  end

  def target_check(data)
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

# Takes care about the client interactions
class Enerbot
  extend PeyosRegex

  Slack.configure do |config|
    config.token = BOT_TOKEN
    config.raise 'Missing Bot token' unless config.token
  end

  @client = Slack::RealTime::Client.new
  @web_client = Slack::Web::Client.new

  def self.listen
    @client.on :message do |data|
      text = data.text

      Reply.new(data) if text =~ BOT_CASE
    end

    @client.start!
  end

  def self.message(data, text, attach = '')
    p data
    target_check(data)
    find = attach_check(text, attach)

    Message.new(text, find, @channel, @thread, @ts)
  end
end
