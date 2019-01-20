# Validates origin and permissions over request
module Validate
  BOT_ADMINS = ENV['SLACK_USERS']
  BOT_CHANNELS = ENV['SLACK_CHANNELS']
  BAN_LIST = ''.freeze

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
      Resp.message('#bots', "User <@#{user}> tried to do something nasty")
    when 'LOCKED ORIGIN'
      Resp.message('#bots', "User <@#{user}> making me work on <##{channel}|#{channel}>")
      nil
    end
  end
end

# Differentiates the request type and triggers the happy response
class Reply
  extend Validate

  def initialize(data, reply)
    data.respond_to? :channel
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
      Resp.message('#bots', reply) unless Reply.redirect(scope, user, channel).nil?
      Resp.message(data, Case.bot(data)) if Reply.redirect(access, user, channel).nil?
    end
  end
end
