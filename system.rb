ADM_LOG = ENV['SLACK_LOG_BOT']
BOT_ADMINS = ENV['SLACK_USERS']
BOT_CHANNELS = ENV['SLACK_CHANNELS']
BAN_LIST = ''

# Admin stuff
module Admin
  def ban(data)
    BAN_LIST << data unless data =~ /#{ENV['SUPER_USER']}/
  end
end

# Security checks of permissions and others herbs
module Validate
  def worthy?(user)
    'NOT' if BAN_LIST.include?(user)
  end

  def admin?(user)
    'COMMON' unless BOT_ADMINS.include?(user)
  end

  def super?(text)
    'YES' if text =~ /(enersay|enerban|enershut)/
  end

  def channel?(chan)
    'LOCKED ORIGIN' unless BOT_CHANNELS.include?(chan)
  end
end

# # Persona music live
# class Memories
#   @chat_info = "*CHAT:*\n"
#   @thread_info = "*THREADS:*\n"
#
#   hola = []
#   def initialize(data)
#     @user = data.user
#     @chan = data.channel
#     @text = data.text
#     @thread = data.thread_ts
#   end
#
#   def thread
#     info = "*Channel:* #{@chan}, *Thread:* #{@thread}, *User:* <@#{@user}>, *Text:* #{@text}\n"
#     @thread_info += info unless @thread.nil? && @user != 'enerbot' && !@text.to_s.match(/(enerbot|enerinfo)/)
#   end
#
#   def chat
#     info = "*Channel:* #{@chan}, *User:* <@#{@user}>, *Text:* #{@text}\n"
#     @chat_info += info unless @user != 'enerbot' && !@text.to_s.match(/(enerbot|enerthread)/)
#   end
#
#   def thread_val
#     @thread_info
#   end
#
#   def chat_val
#     @chat_info
#   end
# end

# Handles all the magical logic for permissions
class Redirect
  extend Validate

  def initialize(data)
    user = data.user
    channel = data.channel
    text = data.text

    @user = user
    @channel = channel

    @admin = Redirect.admin?(user)
    @channel = Redirect.channel?(channel)
    @cmd = Redirect.super?(text)
    @rights = Redirect.worthy?(user)
  end

  def shift
    if @admin == 'COMMON'
      Enerbot.message(ADM_LOG, "User <@#{@user}> tried to do something nasty")
    elsif @channel == 'LOCKED ORIGIN'
      Enerbot.message(ADM_LOG, "User <@#{@user}> making me work on <##{@channel}|#{@channel}>")
      nil
    elsif @rights == 'NOT'
      Enerbot.message(@channel, "*User:* <@#{@user}> is banned until i forget it :x:")
    end
  end

  def super
    @cmd
  end
end

# Send message with response if it's valid
class Reply
  def initialize(data)
    text = data.text

    validations = Redirect.new(data)
    check = validations.shift
    cmd = validations.super

    if cmd == 'YES' && check.nil?
      case text
      when /enerban/
        Enerbot.ban(text)
      when /enershut/
        Enerbot.message(data, Case.kill(text)) && abort('bye')
      when /enersay/
        chan, message = Enerbot.say(text)
        Enerbot.message(chan, message)
      end
    else
      value = Case.bot(data)
      unless value.nil?
        Enerbot.message(ADM_LOG, text) unless check.nil?
        Enerbot.message(data, value) if check.nil?
      end
    end
  end
end
