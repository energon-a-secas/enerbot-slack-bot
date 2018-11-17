# Module for blockchain
module Celery
  def self.load(data)
    case data.text
    when /celery/i then 'https://i.imgur.com/6MqOJUg.gif'
    when /tayne/i then 'https://i.gifer.com/3zzS.gif'
    when /(hat wobble|flarhgunnstow)/i then 'https://i.imgur.com/SOlzkvP.gif'
    when /4d3d3d3/i then 'http://i.imgur.com/noJWe.gif'
    when /oyster/i then 'https://i.gifer.com/4fwu.gif'
    end
  end
end
