# Works as a Database
module Registry
  def save(data)
    user = data.user
    chan = data.channel
    text = data.text
    thread = data.thread_ts

    info = "*Channel:* #{chan}, *Thread:* #{thread}, *User:* <@#{user}>, *Text:* #{text}\n"
    ADM_REGISTRY << info unless thread.nil? && user != 'enerbot' && !text.to_s.match(/(enerbot|enerinfo)/)
  end

  def remember(data)
    user = data.user
    chan = data.channel
    text = data.text

    info = "*Channel:* #{chan}, *User:* <@#{user}>, *Text:* #{text}\n"
    BROTHER_EYE << info unless user != 'enerbot' && !text.to_s.match(/(enerbot|enerthread)/)
  end

  def self.thread
    ADM_REGISTRY
  end

  def self.info
    BROTHER_EYE
  end
end

# Admin stuff
module Admin
  def ban(data)
    text = data.text
    ADM_BAN << text
  end

  def reset
    ADM_BAN.clear
  end
end

# Security checks of permissions and others herbs
module Validate
  # Validates if user is banned
  def worthy?(user)
    'NOT' if ADM_BAN.include?(user)
  end

  # Checks admin rights
  def admin?(user)
    'COMMON' unless BOT_ADMINS.include?(user)
  end

  # Check privileged commands
  def super?(text)
    'YES' if text =~ /(enersay|ban|enershut)/
  end

  # Validates if the specified channel is whitelisted
  def channel?(chan)
    'LOCKED ORIGIN' unless BOT_CHANNELS.include?(chan)
  end

  # Differentiates the permissions for the calling user based on the channel
  def redirect(value, user, channel)
    case value
    when 'NOT'
      Enerbot.message(channel, "*User:* <@#{user}> is banned until i forget it :x:")
    when 'COMMON'
      Enerbot.message(ADM_LOG, "User <@#{user}> tried to do something nasty")
    when 'LOCKED ORIGIN'
      Enerbot.message(ADM_LOG, "User <@#{user}> making me work on <##{channel}|#{channel}>")
      nil
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
        Enerbot.message(data, Case.kill(text)) && abort('bye') if Reply.redirect(admin, user, channel).nil?
      when /enersay/
        chan, message = Enerbot.say(text)
        Enerbot.message(chan, message) if Reply.redirect(admin, user, channel).nil?
      end
    else
      Enerbot.message(BOT_LOG, reply) unless Reply.redirect(scope, user, channel).nil?
      Enerbot.message(data, Case.bot(data)) if Reply.redirect(access, user, channel).nil?
    end
  end
end
