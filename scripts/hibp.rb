# Module for search elements in Have I Been Pwned
module HIBP
  def self.check_email(text)
    require 'net/http'
    require 'json'
    if (match = text.match(/pwned email (.*?)$/i))
      email = match.captures[0]
    end

    message = "No info for #{email}"
    if email
      http = Net::HTTP.new('haveibeenpwned.com', 443)
      http.use_ssl = true
      req = Net::HTTP::Get.new("/api/v2/breachedaccount/#{email}", 'User-Agent' => 'enerbot-hibo-email')
      res = http.request(req)

      if res.code == '200'
        breaches = JSON.parse(res.body)
        message = "Email #{email} Brechas: *#{breaches.length}*"
        breaches.each do |breach|
          message += "\t:rotating_light: #{breach['Title']} (#{breach['Domain']}) #{breach['BreachDate']}\n"
        end
      elsif res.code == '429'
        message = '_Rate limit exceeded_ :wait_energon:'
      end

    else
      message = 'No email readed'
    end
    <<-HEREDOC
        #{message}
    HEREDOC
  end
end
