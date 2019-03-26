require 'slack-ruby-client'
require './core'
require './system'

# Every variable that you would dream of
module Definitions
  BOT_TOKEN = ENV['SLACK_API_TOKEN']
  BOT_CHANNEL = ENV['SLACK_LOG_BOT']
  BOT_ICON = ENV['SLACK_ICON']
  BOT_NAME = ENV['SLACK_NAME']
  BOT_CASE = /^(ener[brs])/i
  BOT_CASE_EMOJI = /(mcafee|partyenergon|homero)/
end

# Checks the text for selecting the correct method
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

# Takes care about the client interactions
class Enerbot < EnerCheck
  include Definitions

  Slack.configure do |config|
    config.token = BOT_TOKEN
    config.raise 'Missing Bot token' unless config.token
  end

  @client = Slack::RealTime::Client.new
  @web_client = Slack::Web::Client.new

  def self.listen
    client = @client

    client.on :message do |data|
      text = data.text

      Reply.new(data) if text =~ BOT_CASE
    end

    client.start!
  end

  def self.message(data, text, attach = '')
    p data

    target_check(data)
    find = attach_check(text, attach)

    if text =~ BOT_CASE_EMOJI
      reaction(text)
    elsif text =~ /.png/
      attach(text)
    else
      write(text, find)
    end
  end

  def self.reaction(text)
    @web_client.reactions_add channel: @channel,
                              name: text,
                              timestamp: @thread,
                              icon_url: BOT_ICON,
                              username: BOT_NAME
  end

  def self.write(text, find = '')
    text = '' if text =~ /.json/
    @client.web_client.chat_postMessage channel: @channel,
                                        text: text,
                                        thread_ts: @thread,
                                        icon_url: BOT_ICON,
                                        username: BOT_NAME,
                                        attachments: find
  end

  def self.attach(file)
    path_to_file = "./emojis/#{file}"
    @client.web_client.files_upload channels: @channel,
                                    initial_comment: 'Dumped from my database',
                                    thread_ts: @thread,
                                    icon_url: BOT_ICON,
                                    username: BOT_NAME,
                                    file: Faraday::UploadIO.new(path_to_file, 'text'),
                                    title: File.basename(path_to_file),
                                    filename: File.basename(path_to_file)
  end
end
