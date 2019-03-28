require 'slack-ruby-client'
require './enercore'

# Represents a beautiful incoming user message
class UserData
  attr_accessor(:val)

  def self.message(text)
    @text = text
  end

  def self.text
    @text
  end

  def self.user
    'user'
  end

  def self.channel
    '#bot_monitoring'
  end
end
