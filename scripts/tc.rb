module Credit
  def self.gen(data)
    require 'credy'
    text = data.text.split[2]
    puts text
    puts data

    datos = Credy::CreditCard.generate options = { type: text }
    'Beta feature ' + datos.to_s
  end
end
