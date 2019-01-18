# Tira un dado
module Roleo
  def self.dados(text)
    require 'easy_dice'
    dado = '1d20'
    if (match = text.match(/roll (.*?)$/i))
      dado = match.captures[0]
     end
    d = begin
       EasyDice.read(dado)
        rescue StandardError
          EasyDice.read('1d20')
     end
    <<-HEREDOC
		#{d.roll}
    HEREDOC
  end
end
