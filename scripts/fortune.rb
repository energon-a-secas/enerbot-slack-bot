# Fortune cookies for everyone
module Fortune
  def self.cookie(user)
    require 'open-uri'
    document = open('https://raw.githubusercontent.com/larryprice/fortune-cookie-api/master/data/proverbs.txt').read
    messages = document.split("\n")
    <<-HEREDOC
<@#{user}> :fortune_cookie: «#{messages.sample}»
    HEREDOC
  end
end
