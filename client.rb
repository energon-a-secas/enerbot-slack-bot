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

    File.new('black_list.log', 'w')

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

      case text
      when /^(ener[brs])/i then
        client.typing channel: chan
        Reply.new(data)
      end
    end

    client.start!
  end

  def self.message(data, text, attach = '')
    puts data

    find = if attach != ''
             json_file = File.read("./Info/#{text}")
             text = ':energon_enterprise:'
             JSON.parse(json_file)[attach]
           else
             []
           end

    channel, ts = if data.respond_to? :channel
                    [data.channel, '']
                  else
                    check = data.match(/(.*):(\d*.\d*)/)
                    if check
                      [check[1], check[2]]
                    else
                      [data, '']
                    end
                  end

    thread = if data.respond_to? :thread_ts
               data.ts
             elsif !ts.empty?
               ts
             end

    client = Slack::RealTime::Client.new
    web_client = Slack::Web::Client.new

    if text =~ /(mcafee|partyenergon|homero)/
      web_client.reactions_add channel: channel,
                               name: text,
                               icon_url: @bot_icon,
                               username: @bot_name,
                               timestamp: thread

    else
      client.web_client.chat_postMessage channel: channel,
                                         text: text,
                                         icon_url: @bot_icon,
                                         username: @bot_name,
                                         thread_ts: thread,
                                         attachments: find

    end
  end
end

Enerbot.new
