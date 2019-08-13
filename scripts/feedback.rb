module Feedback
  def self.quote
    quotes = [
      'Lo hiciste excelente durante el año. *Bajo lo esperado*',
      'Jugaste fifa todo el año. *Excepcional*, sigue así',
      'Jugaste magic en la oficina. *Bajo lo esperado*',
      'Tomaste desayuno en la oficina 2 veces en el año. *Bajo lo esperado*',
      'Eres parte de la comunidad de seguridad. *Excepcional*',
      'No incluiste ninguna palabra en ingles en tus frases. *Bajo lo esperado*',
      'Pusiste solo emojis tristes en slack. *Bajo lo esperado*',
      'Saliste 2 veces en el _NEWS_ hablando sobre la importancia de los terraplanistas. *Excepcional*',
      'Fuiste el mejor en el baile para romper el hielo en el workshop. *Excepcional*'
    ]

    <<-HEREDOC
    > #{quotes.sample}
    HEREDOC
  end

  def self.meh
    per = (1..100).to_a.shuffle!

    icon = case per
           when 1..10
             ':thunder_cloud_and_rain:'
           when 11..20
             ':rain_cloud:'
           when 21..30
             ':cloud:'
           when 31..40
             ':partly_sunny:'
           when 41..49
             ':mostly_sunny:'
           when 50
             ':partly_sunny_rain:'
           when 51..70
             ':sunny:'
           when 71..80
             ':full_moon_with_face:'
           when 81..99
             ':rainbow:'
           when 100
             ':newalert:'
           end
    ":softlayer-icon: lleva #{(Date.parse('4/8/2019').Date.today).count} días arriba y contando.\nProbabilidad de incidente: #{per[0]}% #{icon}"
  end
end
