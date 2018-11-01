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
      *Amor:* #{signo['amor']}
      *Salud:* #{signo['salud']}
      *Dinero:* #{signo['dinero']}
      *Color:* #{signo['color']}
      *Número:* #{signo['numero']}
      HEREDOC
    else
      "[WARN] No es canon #{option}"
    end
  end
end
