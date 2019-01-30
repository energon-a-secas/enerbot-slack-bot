require 'slack-ruby-client'
require './core'
require './system'

# Future wave Gem
class Enerbot
  attr_reader :token, :channel
  extend Admin

  @bot_icon = ENV['SLACK_ICON']
  @bot_name = ENV['SLACK_NAME']

  def initialize(token: ENV['SLACK_API_TOKEN'], channel: ENV['SLACK_LOG_BOT'])
    @bot_token = token
    @bot_channel = channel

    File.new('black_list.log', "w")

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

      # mem = Memories.new(data)
      # mem.thread
      # mem.chat

      case text
      when /^enerbot/i then
        client.typing channel: chan
        Reply.new(data)
      when /^(enersay|enershut|enerrest|enerban)/ then
        Reply.new(data)
        # when /^enerthread/ then
        #   Enerbot.message(data, mem.thread_val.to_s)
        # when /^enerinfo/ then
        #   Enerbot.message(data, mem.chat_val.to_s)
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
                                       icon_url: @bot_icon,
                                       username: @bot_name,
                                       thread_ts: thread,
                                       attachments: find
  end

  def self.say(text)
    match = text.match(/enersay (\<[#@])?((.*)\|)?(.*?)(\>)? (.*?)$/i)
    [match.captures[2] || match.captures[3], match.captures[5]] unless match.nil?
  end
end

Enerbot.new
