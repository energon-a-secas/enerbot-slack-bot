require 'slack-ruby-client'
require './scripts/date'
require './scripts/system'
require './scripts/quote'
require './scripts/ssh'
require './scripts/pass'
require './scripts/tc'
require './scripts/2fa'
require './scripts/random'
require './scripts/horoscopo'
require './scripts/lotery'
require './scripts/security_check'
require './scripts/wikipedia'
require './scripts/celery'
require './scripts/lingo'
require './scripts/stock'
require './scripts/qr'
require './scripts/flight'
require './scripts/weather'
require './client'
require './core'

class BotValue
  BOT_ICON = ':energon:'.freeze
  BOT_NAME = 'ENERTEST'.freeze
  BOT_ADMINS = 'user'.freeze

  def self.text
    MESSAGE
  end

  def self.user
    'user'
  end

  def self.channel
    '#bots'
  end
end
