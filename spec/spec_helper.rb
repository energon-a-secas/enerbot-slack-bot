require 'slack-ruby-client'
require './enercore'

# Represents a beautiful incoming user message
class UserData

  def self.text
    'hola'
  end

  def self.user
    'user'
  end

  def self.channel
    '#bot_monitoring'
  end
end
