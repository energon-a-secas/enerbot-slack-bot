module Totp
  def self.gen(data)
    require 'rotp'
    holi = data.text.to_s.split(/\b2fa /)
    totp = ROTP::TOTP.new(holi[1])
    p "Current OTP: #{totp.now}"
  end
end
