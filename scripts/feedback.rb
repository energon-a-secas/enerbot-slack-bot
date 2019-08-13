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
end
