# Validates origin and permissions over request

BOT_ADMINS = ENV['SLACK_USERS']
BOT_CHANNELS = ENV['SLACK_CHANNELS']
BOT_ICON = ENV['SLACK_ICON']
BOT_NAME = ENV['SLACK_NAME']
BAN_LIST = ''

module Registry
  def save(data)
    user = data.user
    chan = data.channel
    text = data.text
    thread = data.thread_ts
    @thread = ''
    @thread << "\n*Channel:* #{chan}, *Thread:* #{thread}, *User:* <@#{user}>, *Text:* #{text}" unless thread.nil? && user != 'enerbot' && !text.to_s.include?('enerbot')
  end

  def thread
    p @thread
  end
end

module Validate

  # Validates if user is banned
  def worthy?(user)
    'NOT' if BAN_LIST.include?(user) # || !ADMIN_LIST.include?(user)
  end

  def admin?(user)
    'COMMON' unless BOT_ADMINS.include?(user)
  end

  def super?(text)
    'YES' if text =~ /(enersay|enershut)/
  end

  # Validates if the specified channel is whitelisted
  def channel?(chan)
    'LOCKED ORIGIN' unless BOT_CHANNELS.include?(chan)
  end

  # Differentiates the permissions for the calling user based on the channel
  def redirect(value, user, channel)
    case value
    when 'NOT'
      Resp.message(channel, 'You are still banned until i forget it')
    when 'COMMON'
      Resp.message(BOT_LOG, "User <@#{user}> tried to do something nasty")
    when 'LOCKED ORIGIN'
      Resp.message(BOT_LOG, "User <@#{user}> making me work on <##{channel}|#{channel}>")
      nil
    end
  end
end

# Works somehow
module Resp
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

  def self.write(data, text, thread = '')
    puts data
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data,
                                       text: text,
                                       icon_url: BOT_ICON,
                                       username: BOT_NAME,
                                       thread_ts: thread
  end

  def self.say(text)
    if (match = text.match(/enersay (\<[#@])?((.*)\|)?(.*?)(\>)? (.*?)$/i))
      [match.captures[2] || match.captures[3], match.captures[5]]
    else
      ['#bots', 'Meh']
    end
  end
end

# Differentiates the request type and triggers the happy response
class Reply
  extend Validate

  def initialize(data, reply)
    user = data.user
    text = data.text
    channel = data.channel

    access = Reply.worthy?(user)
    admin = Reply.admin?(user)
    cmd = Reply.super?(text)
    scope = Reply.channel?(channel)

    if cmd
      case reply
      when /enershut/
        Resp.message(data, Case.kill(text)) && abort('bye') if Reply.redirect(admin, user, channel).nil?
      when /enersay/
        chan, message = Resp.say(text)
        Resp.message(chan, message) if Reply.redirect(admin, user, channel).nil?
      end
    else
      Resp.message(BOT_LOG, reply) unless Reply.redirect(scope, user, channel).nil?
      Resp.message(data, Case.bot(data)) if Reply.redirect(access, user, channel).nil?
    end
  end
end
