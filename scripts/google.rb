# The first step to join the giant...
module Google
  def self.safebrowsing(text)
    require 'net/http'
    require 'uri'
    require 'json'

    host = ''
    if (input = text.match(/safe browsing ((.*)\|)?(.*?)(\>)?$/i))
      host = input.captures[2]
    end

    uri = URI.parse("https://safebrowsing.googleapis.com/v4/threatMatches:find?key=#{ENV['GSBAK']}")

    header = { 'Content-Type': 'application/json' }
    payload = {
      "client": {
        "clientId": 'enerbot',
        "clientVersion": '0.2.4'
      },
      "threatInfo": {
        "threatTypes": %w[MALWARE SOCIAL_ENGINEERING UNWANTED_SOFTWARE],
        "platformTypes": ['ANY_PLATFORM'],
        "threatEntryTypes": ['URL'],
        "threatEntries": [
          { "url": host }
        ]
      }
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = payload.to_json

    response = http.request(request)
    result = JSON.parse(response.body)

    message = "URL #{host} seems clean"
    unless result.empty?
      message = "Oh-oh... #{host} has some threats:\n"
      result['matches'].each do |match|
        message += "\tThreat type: #{match['threatType']} - Platform: #{match['platformType']}\n"
      end
    end
    <<-HEREDOC
#{message}
    HEREDOC
  end
end
