# Module for the most popular activity at xmas
module SecretFriend
  def self.generate(text)
    if (match = text.match(/amigo secreto (.*?)$/i))
      friends = match.captures[0]
    end
    friend_list = friends.split(',').shuffle
    message = 'La lista sigue así: '
    if friend_list.length > 2
      (0..(friend_list.length - 2)).each do |index|
        message += "*#{friend_list[index]}* regala a *#{friend_list[index + 1]}*, "
      end
      message += "*#{friendList[friendList.length - 1]}* regala a *#{friendList[0]}*.\n"
      message += "Monto máximo sugerido para regalo: $#{rand(5_000..10_000)}"
    else
      message = 'Al menos deben ser 3 amigos... No creo que sea tan difícil ¿o no?'
    end
    <<-HEREDOC
#{message}
    HEREDOC
  end
end
