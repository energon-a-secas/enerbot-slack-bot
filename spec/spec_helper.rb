require 'slack-ruby-client'
require './enercore'

# Represents a beautiful incoming user message
class UserData
  def self.message(text)
    @text = text
  end

  class << self
    attr_reader :text
  end

  def self.user
    'user'
  end

  def self.channel
    '#bot_monitoring'
  end
end
