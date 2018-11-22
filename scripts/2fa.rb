# Why not?
module Totp
  def self.gen(text)
    require 'rotp'
    if (match = text.match(/2fa (.*?)$/i))
      key = match.captures[0]
    end
    totp = ROTP::TOTP.new(key)
    "Current OTP: #{totp.now}"
  end
end
