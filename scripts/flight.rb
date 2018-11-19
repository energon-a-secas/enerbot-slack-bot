require 'json'
require 'date'
require 'open-uri'

# Module for flights (you don't say...)
module Flight
  def self.info(text)
    vuelo = 'NO ARGS'
    if (match = text.match(/vuelo (.*?)$/i))
      vuelo = match.captures[0]
    end
    message = "No info for [#{vuelo}]"
    document = open("https://es.flightaware.com/live/flight/#{vuelo}").read
    if (match = document.match(%r{var\strackpollBootstrap\s=\s(.*?)\;\<\/script\>}))
      f = match.captures[0]
      js = JSON.parse(f)
      flight_key = js['flights'].keys[0]

      if flight_key !~ /INVALID/i
        arr_est_time = Time.at(js['flights'][flight_key]['landingTimes']['estimated'])
        dep_est_time = Time.at(js['flights'][flight_key]['takeoffTimes']['estimated'])

        dep_time = dep_est_time.to_s > Time.now.to_s ? 'Next' : 'Last'
        arr_time = arr_est_time.to_s > Time.now.to_s ? 'Next' : 'Last'

        message = ':airplane: *Flight '
        message += "#{js['flights'][flight_key]['friendlyIdent']}*\n"
        message += ':cityscape: *From* '
        message += "#{js['flights'][flight_key]['origin']['friendlyLocation']}\n"
        message += ':cityscape: *To* '
        message += "#{js['flights'][flight_key]['destination']['friendlyLocation']}\n"
        message += ":airplane_departure: *#{dep_time} Departure:* "
        message += "#{dep_est_time.strftime('%Y-%m-%d %H:%M:%S %:z')}\n"
        message += ":airplane_arriving: *#{arr_time} Arrival:* "
        message += arr_est_time.strftime('%Y-%m-%d %H:%M:%S %:z').to_s
      end
    end
    <<-HEREDOC
        #{message}
    HEREDOC
  end
end
