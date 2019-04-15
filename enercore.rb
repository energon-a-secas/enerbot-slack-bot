require 'slack-ruby-client'
require './core'
require './message'
require './system'

# Obtains channel, thread, ts and attachments from incoming data
module DataSelector
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

# Configures and runs the Slack client
class EnerCore
  extend DataSelector
  attr_accessor(:log_channel, :token, :bot_case)

  def initialize(log_channel = ENV['SLACK_LOG_BOT'], token = ENV['SLACK_API_TOKEN'])
    Slack.configure do |config|
      config.token = token
      config.raise 'Missing Bot token' unless config.token
    end

    @client = Slack::RealTime::Client.new
    @web_client = Slack::Web::Client.new

    @client.on :hello do
      EnerCore.send(log_channel, 'Beginning LERN sequence')
    end
  end

  def listen
    @client.on :message do |data|
      text = data.text

      result = Event.select(data)

      EnerCore.send(data, result) unless result.nil?

      Reply.new(data) if text =~ /^(ener[abrs])/i
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
