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
require './scripts/flight'
require './scripts/weather'
require './scripts/cves'
require './scripts/canitrot'
require './scripts/bronze'
require './scripts/macaulay'
require './scripts/haarp'
require './scripts/secret_friend'
require './scripts/dns'
require './scripts/hibp'
require './scripts/fire'
require './scripts/acme'
require './scripts/chimuelo'
require './core'
require './system'

BOT_TOKEN = ENV['SLACK_API_TOKEN']
BOT_LOG = ENV['SLACK_LOG_CHANNEL']

# Future Gem
class Enerbot
  extend Registry

  def initialize

    # Slack Token configure
    Slack.configure do |config|
      config.token = BOT_TOKEN
      config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
    end

    # Client initialization
    client = Slack::RealTime::Client.new

    client.on :hello do
      Resp.message(BOT_LOG, 'Beginning LERN sequence')
    end

    # Listen to new messages
    client.on :message do |data|
      #user = data.user
      chan = data.channel
      text = data.text

      Enerbot.save(data)

      # First layer of case
      case text
      when /^enerbot/i then
        client.typing channel: chan
        Reply.new(data, text)
      when /^enersay/ then
        Reply.new(data, text)
      when /^enershut/ then
        Reply.new(data, text)
      end
    end

    client.start!
  end

end

Enerbot.new