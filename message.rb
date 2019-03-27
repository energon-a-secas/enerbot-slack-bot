module Definitions
  BOT_ICON = ENV['SLACK_ICON']
  BOT_NAME = ENV['SLACK_NAME']
  BOT_CASE_EMOJI = /(mcafee|partyenergon|homero)/
end

# Zelda
class Message
  include Definitions

  def initialize(text, find, channel, thread)
    @channel = channel
    @thread = thread
    @client = Slack::RealTime::Client.new
    @web_client = Slack::Web::Client.new

    if text =~ BOT_CASE_EMOJI
      reaction(text)
    elsif text =~ /.png/
      attach(text)
    else
      write(text, find)
    end
  end

  def reaction(text)
    @web_client.reactions_add channel: @channel,
                              name: text,
                              timestamp: @thread,
                              icon_url: BOT_ICON,
                              username: BOT_NAME
  end

  def write(text, find = '')
    text = '' if text =~ /.json/
    @client.web_client.chat_postMessage channel: @channel,
                                        text: text,
                                        thread_ts: @thread,
                                        icon_url: BOT_ICON,
                                        username: BOT_NAME,
                                        attachments: find
  end

  def attach(file)
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
