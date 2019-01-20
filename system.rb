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
    'YES' if BOT_ADMINS.include?(user)
  end

  # Validates if the specified channel is whitelisted
  def channel?(chan)
    'LOCKED ORIGIN' unless BOT_CHANNELS.include?(chan)
  end

  # Differentiates the permissions for the calling user based on the channel
  def redirect(value, user, channel)
    case value
    when 'NOT'
      if BAN_LIST.include?(user)
        Resp.message(channel, 'You are still banned until i forget it')
      elsif BOT_ADMINS.include?(user)
        Resp.message('#bots', "User <@#{user}> tried to do something nasty")
      end
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
    scope = Reply.channel?(channel)

    if Reply.admin?(user) && reply.include?('say')
      admin = Reply.admin?(user)
      chan, message = Resp.say(text)
      Resp.message(chan, message) if Reply.redirect(admin, user, channel).nil?
    else
      Resp.message('#bots', reply) unless Reply.redirect(scope, user, channel).nil?
      Resp.message(data, Case.bot(data)) if Reply.redirect(access, user, channel).nil?
    end
  end
end
