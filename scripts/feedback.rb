module Feedback
  def self.quote
    quotes = [
      'Lo hiciste excelente durante el año. *Bajo lo esperado*',
      'Jugaste fifa todo el año. *Excepcional*, sigue así',
      'Jugaste magic en la oficina. *Bajo lo esperado*',
      'Tomaste desayuno en la oficina 2 veces en el año. *Bajo lo esperado*',
      'Eres parte de la comunidad de seguridad. *Excepcional*'
    ]

    <<-HEREDOC
    > #{quotes.sample}
    HEREDOC
  end
end
