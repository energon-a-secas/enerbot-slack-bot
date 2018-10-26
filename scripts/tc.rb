module Credit
  def self.gen(data)
    require 'credy'
    text = data.text.split[2]
    tarjetas = %w[mastercard
                  solo
                  visa
                  americanexpress
                  bankcard]
    if tarjetas.include? text
      puts data
      datos = Credy::CreditCard.generate options = { type: text }
      'Beta feature ' + datos.to_s
    else
      "[WARN] We are not currently supporting #{text}"
  end
  end
end
