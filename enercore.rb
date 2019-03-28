require 'slack-ruby-client'
require './message'
require './core'
require './system'

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
class EnerCore
  extend PeyosRegex
  attr_accessor(:log_channel, :token, :bot_case)

  def initialize(log_channel = ENV['SLACK_LOG_BOT'], token = ENV['SLACK_API_TOKEN'], bot_case = /^(ener[abrs])/i)
    Slack.configure do |config|
      config.token = token
      config.raise 'Missing Bot token' unless config.token
    end

    @case = bot_case
    @client = Slack::RealTime::Client.new
    @web_client = Slack::Web::Client.new

    @client.on :hello do
      EnerCore.send(log_channel, 'Beginning LERN sequence')
    end

  end

  def listen
    @client.on :message do |data|
      text = data.text

      Reply.new(data) if text =~ @case
    end

    @client.start!
  end

  def self.send(data, text, attach = '')
    p data
    target_check(data)
    find = attach_check(text, attach)

    Message.new(text, find, @channel, @thread, @ts)
  end
end
