require 'json'
require 'net/http'

# Module for Peyo's security adventures
module Peyo
  def self.check(text)
    url = text.split[2].split('|')[1].chomp('>')
    uri = "https://sitecheck.sucuri.net/api/v2/?scan=#{url}"
    analisis = JSON.parse(Net::HTTP.get(URI(uri)))
    recommendations = analisis['RECOMMENDATIONS']['LIST']
    string_analisis = 'NINGUN WARNING, FELICITACIONES :clap2:'
    if analisis['RECOMMENDATIONS'].key?('LIST')
      string_analisis = "WARNINGS \n "
      recommendations.each do |x|
        string_analisis += ":warning: #{x} \n"
      end
      string_analisis += "\nMAS INFORMACION EN: https://sitecheck.sucuri.net/results/#{url}\n"
    end
    <<-HEREDOC
        #{string_analisis}
    HEREDOC
  end
end
