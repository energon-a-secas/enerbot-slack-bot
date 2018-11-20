# Module to list CVE (valuable security)
module CVE
    def self.latest(data)
        require 'json'
        require 'net/http'
        require 'uri'

        num = 5
        if (match = data.match(/cve list (.*?)$/i))
            num = match.captures[0]
        end

        result = JSON.parse(Net::HTTP.get(URI('https://cve.circl.lu/api/last')))

        message = ''
        result&.each_with_index { |x, index|
            if index == num.to_i then break end
            message += "*#{x['id']}*:\n> _#{x['summary']}_ \n"   
        }

        <<-HEREDOC
            #{message}
        HEREDOC
    
    end

end
