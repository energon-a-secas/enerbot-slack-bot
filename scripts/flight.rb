require 'json'
require 'date'
require 'open-uri'

module Flight
    def self.info(text)       
        vuelo = 'NO ARGS'
        if match = text.match(/vuelo (.*?)$/i)
            vuelo = match.captures[0]
        end
        message = "No info for [#{vuelo}]"
        document = open("https://es.flightaware.com/live/flight/#{vuelo}").read
        if match = document.match(/\<script\>var\strackpollBootstrap\s=\s(.*?)\;\<\/script\>/)
            f = match.captures[0]
            js = JSON.parse(f)
            flightKey = js['flights'].keys[0]
            
            if flightKey !~ /INVALID/i
                arrEstTime = Time.at(js['flights'][flightKey]['landingTimes']['estimated']).to_datetime
                depEstTime = Time.at(js['flights'][flightKey]['takeoffTimes']['estimated']).to_datetime
                
                depTime = depEstTime.to_s > Time.now.to_datetime.to_s ? 'Next' : 'Last'
                arrTime = arrEstTime.to_s > Time.now.to_datetime.to_s ? 'Next' : 'Last'

                message = "*Flight #{js['flights'][flightKey]['friendlyIdent']}*\n"
                message += "*From* #{js['flights'][flightKey]['origin']['friendlyLocation']}\n"
                message += "*to* #{js['flights'][flightKey]['destination']['friendlyLocation']}\n"
                message += "*#{depTime} Departure:* #{depEstTime.strftime("%Y-%m-%d %H:%M:%S %:z")}\n"
                message += "*#{arrTime} Arrival:* #{arrEstTime.strftime("%Y-%m-%d %H:%M:%S %:z")}"
            end
        end
        <<-HEREDOC
        #{message}
        HEREDOC

    end
end