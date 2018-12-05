module Haarp
  def self.terre
    require 'json'
    require 'net/http'

    api = JSON.parse(Net::HTTP.get(URI('https://chilealerta.com/api/query/?user=luciano&select=ultimos_sismos&country=chile')))
    terre = api['ultimos_sismos_chile'][0]
    <<-HEREDOC
:clock1: *Hora:* #{terre['chilean_time']}
:earth_americas:*Ubicación:* #{terre['reference']}
:triggered_energon: *Magnitud:* #{terre['magnitude']}
    HEREDOC
  end
end
