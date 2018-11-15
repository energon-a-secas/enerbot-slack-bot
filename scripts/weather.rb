# Module weather forecast... please find an API
# based on jorgeepunan clima.js
require 'open-uri'

module Ivan
    def self.torres(text)
        location = 'Santiago'
        if match = text.match(/clima\s(.*?)$/i)
            location = match.captures[0]
        end
        html = open("https://wttr.in/#{location}?m", 'User-Agent' => 'curl/7.62.0').read
        weather = ''
        html.split(/\n/).each do |line|
            if !line.match(/\s+┌─────────────┐\s+/)
                weather += line.gsub(/\[(\d+)?((;\d+)+)?(m)?/,'') + "\n"
            else
                break 
            end
        end
        message = weather.empty? ? 'Try another location' : weather
        <<-HEREDOC
        ```#{message}```
        HEREDOC
    end
    
end




