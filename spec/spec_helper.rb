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
require './core'

class AccessEval
  BOT_ICON = ':energon:'.freeze
  BOT_NAME = 'ENERBETAS'.freeze
  BOT_ADMINS = 'user'.freeze

  def self.text
    [
      'enerbot hola',
      'enerbot pregunta',
      'enerbot como estas',
      'enerbot beneficio',
      'enerbot pack',
      'enerbot rules',
      'enerbot cuándo pagan',
      'enerbot cuanto para el 18',
      'enerbot password',
      'enerbot password sec',
      'enerbot 2fa asadasd',
      'enerbot random 1 2 3',
      'enerbot horoscopo piscis',
      'enerbot resultados kino',
      'enerbot dame numeros para el kino',
      'enerbot valor accion energon',
      'enerbot qr hola',
      'enerbot vuelo LAN122',
      'enerbot clima'
    ].sample
  end

  def self.user
    'user'
  end

  def self.channel
    '#bots'
  end
end
