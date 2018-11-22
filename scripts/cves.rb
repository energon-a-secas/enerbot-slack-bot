# Module to list CVE (valuable security)
module CVE
  def self.latest(data)
    require 'json'
    require 'net/http'
    require 'uri'

    num = 5
    if (match = data.match(/cve list (.*?)$/i))
      num = begin
              Integer(match.captures[0])
            rescue StandardError
              num
            end
    end

    result = JSON.parse(Net::HTTP.get(URI('https://cve.circl.lu/api/last')))

    message = ''
    result.each_with_index do |x, index|
      break if index == num.to_i

      message += "*#{x['id']}*:\n> _#{x['summary']}_ \n"
    end

    <<-HEREDOC
            #{message}
    HEREDOC
  end
end
