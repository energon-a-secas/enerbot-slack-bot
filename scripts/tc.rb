# Needs a lot of improvement
module Credit
  def self.gen(text)
    require 'credy'
    type = 'visa'
    if (match = text.match(/tc (.*?)$/i))
      type = match.captures[0]
    end
    tarjetas = %w[mastercard solo visa bankcard]
    if tarjetas.include? type
      data = Credy::CreditCard.generate options = { type: type }
      p ":credit_card:*Type:* #{type}\n:id:*Number:* #{data[:number]}\n:desert_island:*Country:* #{data[:country]}"
    else
      "[WARN] We are not currently supporting #{text}"
    end
  end
end
