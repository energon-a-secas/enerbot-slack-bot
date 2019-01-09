# I just wanna be popular
module Chimuelo
  def self.song(text, user)
    to = ''
    if (match = text.match(/santo sepulcro a (.*?)$/i))
      to = match.captures[0]
    end

    to = to.empty? ? "<@#{user}>" : to

    <<-HEREDOC
:chimuelo:
_«Ave María_
_Señor Jesús_
_Lleva a *#{to}* al ataúd_
_Ave María_
_Don Cristo_
_Lleva a *#{to}*
_A su lugar_

_*#{to}*, descansa, ya estás en paz.»_
:doge:
    HEREDOC
  end
end
