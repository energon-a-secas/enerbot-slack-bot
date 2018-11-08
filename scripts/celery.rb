module Celery
  def self.load(data)
    case data
    when /celery/i
      'https://i.imgur.com/6MqOJUg.gif'
    when /tayne/i
      'https://i.gifer.com/3zzS.gif'
    when /(hat wobble|flarhgunnstow)/i
      'https://i.imgur.com/SOlzkvP.gif'
    when /4d3d3d3/i     
      'http://i.imgur.com/noJWe.gif'
    when /oyster/i
      'https://i.gifer.com/4fwu.gif'
    end
  end
end
