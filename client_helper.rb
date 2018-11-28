class LERN
  def self.channel
    '#bots'
  end
end

module Unauthorized
  def self.chan(data)
    ":newalert: <@#{data.user}> almost make me work on <##{data.channel}>!"
  end
  def self.kill(data)
    "<@#{data.user}> tried to kill me!"
  end

end