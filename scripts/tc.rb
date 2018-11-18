# Needs a lot of improvement
module Credit
  def self.gen(text)
    require 'credy'
    text = text.split[2]
    tarjetas = %w[mastercard solo visa bankcard]
    if tarjetas.include? text
      datos = Credy::CreditCard.generate options = { type: text }
      'Beta feature ' + datos.to_s
    else
      "[WARN] We are not currently supporting #{text}"
  end
  end
end
