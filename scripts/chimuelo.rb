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
        _«Ave María
        Señor Jesús
        Lleva a *#{to}* al ataúd
        Ave María
        Don Cristo
        Lleva a *#{to}*
        A su lugar

        *#{to}*, descansa, ya estás en paz.»_
        :doge:
    HEREDOC
  end
end
