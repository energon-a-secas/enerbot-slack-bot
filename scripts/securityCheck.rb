# Module for Peyo's security adventures
module Peyo
  def self.check(data)
    require 'json'
    require 'net/http'

    url = data.text.split[2].split('|')[1].chomp('>')
    analisis = JSON.parse(Net::HTTP.get(URI('https://sitecheck.sucuri.net/api/v2/?scan=' + url)))
    recommendations = analisis['RECOMMENDATIONS']['LIST']
    stringAnalisis = "NINGUN WARNING, FELICITACIONES :clap2:"
    if analisis['RECOMMENDATIONS'].key?('LIST')
        stringAnalisis = "WARNINGS \n "
        recommendations.each{ |x| 
            stringAnalisis += ":warning: " + x + "\n "
        }
        stringAnalisis += "\nMAS INFORMACION EN: https://sitecheck.sucuri.net/results/" + url + "\n"
    end
    <<~HEREDOC
        #{stringAnalisis}
    HEREDOC
  end
end
