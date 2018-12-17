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
      req = Net::HTTP::Get.new("/api/v2/breachedaccount/#{email}", 'User-Agent' => 'enerbot-hibp-email')
      res = http.request(req)

      if res.code == '200'
        breaches = JSON.parse(res.body)
        plural = breaches.length > 1 ? 's' : ''
        message = "El email \"#{email}\" ha sido listado en *#{breaches.length}* brecha#{plural} :\n"
        breaches.each do |breach|
          domain = breach['Domain'].empty? ? 'Lista de SPAM' : breach['Domain']
          message += "\t:rotating_light: #{breach['Title']} (#{domain}) #{breach['BreachDate']}\n"
        end
        message += "\nTe recomiendo que cambies tus contraseñas (sugiero `enerbot password sec`)"
      elsif res.code == '429'
        message = '_Rate limit exceeded_ :wait_energon:'
      end

    else
      message = 'Debes especificar un email'
    end
    <<-HEREDOC
        #{message}
    HEREDOC
  end
end
