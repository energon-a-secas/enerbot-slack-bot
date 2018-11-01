require 'json'
require 'net/http'

module Pedro
  def self.engel(data)
    option = data.text.split[2]
    signos = %w[aries
                tauro
                geminis
                cancer
                leo
                virgo
                libra
                escorpion
                sagitario
                capricornio
                acuario
                piscis]
    if signos.include? option
      api = JSON.parse(Net::HTTP.get(URI('https://api.adderou.cl/tyaas/')))
      signo = api['horoscopo'][option]
      <<~HEREDOC
      Horóscopo para *#{option}* hoy: #{Date.today}
      *Amor :heart::* #{signo['amor']}
      *Salud :medical_symbol::* #{signo['salud']}
      *Dinero :moneybag::* #{signo['dinero']}
      *Color :art::* #{signo['color']}
      *Número :8ball::* #{signo['numero']}
      HEREDOC
    else
      "[WARN] No es canon #{option}"
    end
  end
end
