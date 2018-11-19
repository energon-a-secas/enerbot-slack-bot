# Module to list CVE (valuable security)
module CVE
    def self.latest(data)
        require 'json'
        require 'net/http'
        require 'uri'

        result = JSON.parse(Net::HTTP.get(URI('https://cve.circl.lu/api/last')))

        message = ''
        result&.each_with_index { |x, index|
            if index == 10 then break end
            message += "*#{x['id']}*:\n> _#{x['summary']}_ \n"   
        }

        <<-HEREDOC
            #{message}
        HEREDOC
    
    end

end
