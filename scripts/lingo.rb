require 'json'
require 'net/http'
require 'uri'
require 'cgi'

# Module for language
module Lingo
  def self.translate(text)
    languages = { 'ingles' => 'en',
                  'español' => 'es',
                  'frances' => 'fr',
                  'portugues' => 'pt',
                  'ruso' => 'ru',
                  'aleman' => 'de',
                  'chino' => 'zh',
                  'japones' => 'ja',
                  'italiano' => 'it',
                  'argentino' => 'es',
                  'chileno' => 'es',
                  'brasileño' => 'pt' }

    flags = { 'ingles' => ':uk:',
              'español' => ':es:',
              'frances' => ':fr:',
              'portugues' => ':flag-pt:',
              'ruso' => ':ru:',
              'aleman' => ':de:',
              'chino' => ':flag-cn:',
              'japones' => ':jp:',
              'italiano' => ':it:',
              'argentino' => ':ar:',
              'chileno' => ':flag-cl:',
              'brasileño' => ':flag-br:' }

    to_translate = ''
    to_language = ''
    if (match = text.match(/como se dice (.*) en (.*?)$/i))
      to_translate, to_language = match.captures
    end

    if languages.key?(to_language) && !to_translate.to_s.empty?
      url = 'https://translate.googleapis.com/translate_a/single?client=gtx&sl=es&tl='
      url += languages[to_language] + '&dt=t&q=' + CGI.escape(to_translate)
      result = Net::HTTP.get(URI(url))

      translated = JSON.parse(result)[0][0][0]
      <<-HEREDOC
                #{translated} #{flags[to_language]}
      HEREDOC
    else
      'https://cdn.memegenerator.es/imagenes/memes/full/22/4/22044287.jpg'
    end
  end
end
