ADM_LOG = ENV['SLACK_LOG_BOT']
BOT_ADMINS = ENV['SLACK_USERS']
BOT_CHANNELS = ENV['SLACK_CHANNELS']
SUPER_COMMAND = ENV['SUPER_COMMAND']
SUPER_USER = ENV['SUPER_USER']

# Admin stuff
module Admin

  def session(user)
    open('black_list.log', 'a') do |f|
      regex = /(?<=\@).*(?=>)/
      user = regex.match(user)[0] if user =~ regex
      f.puts "#{user}\n" unless user =~ /#{ENV['SUPER_USER']}/
    end
  end

  def self.times(data)
    open('black_list.log').grep(/^(#{data})/)
  end
end

# Handles all the magical logic for permissions
class Redirect

  def initialize(data)
    @user = data.user
    @channel = data.channel
    @command = data.text

    @check_admin = BOT_ADMINS.include?(@user)
    @check_ban = Admin.times(@user).empty?
    @check_channel = BOT_CHANNELS.include?(@channel)
    @check_super = SUPER_COMMAND.match?(@command)
  end

  def shift
    if @check_admin == false && @check_super == true
      Enerbot.message(ADM_LOG, "User <@#{@user}> is trying to do something nasty on <##{@channel}|#{@channel}>")
    elsif @check_ban == false
      Enerbot.message(@channel, "*User:* <@#{@user}> is banned until i forget it :x:")
    elsif @check_channel == false
      Enerbot.message(ADM_LOG, "User <@#{@user}> is making me work on <##{@channel}|#{@channel}>")
      nil
    end
  end
end

# Send message with response if it's valid
class Reply
  extend Admin
  def initialize(data)
    text = data.text
    user = data.user

    validations = Redirect.new(data)
    check = validations.shift

    if text =~ /#{ENV['SUPER_COMMAND']}/ && check.nil?
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
      Reply.session("-#{user}")
      attempts = Admin.times("-#{user}").size
      Reply.session(user) if attempts > 4
      unless value.nil?

        Enerbot.message(data, value) if check.nil?
      end
    end
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
