require 'json'
require 'net/http'
require 'uri'

module Lingo
  
    def self.translate(data)
        languages =  {"ingles" => "en", "español" => "es", "frances" => "fr", "portugues" => "pt", "ruso" => "ru", "aleman" => "de",
            "chino" => "zh", "japones" => "ja", "italiano" => "it", "argentino" => "es", "chileno" => "es", "brasileño" => "pt"}

        flags =  {"ingles" => ":uk:", "español" => ":es:", "frances" => ":fr:", "portugues" => ":flag-pt:", "ruso" => ":ru:", "aleman" => ":de:",
            "chino" => ":flag-cn:", "japones" => ":jp:", "italiano" => ":it:", "argentino" => ":ar:", "chileno" => ":flag-cl:", "brasileño" => ":flag-br:"}

        toTranslate, toLanguage = '',''
        if match = data.text.match(/enerbot como se dice (.*) en (.*?)$/i)
            toTranslate, toLanguage = match.captures
        end

        if languages.keys.include? toLanguage and not toTranslate.to_s.empty?
            url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=es&tl=" + languages[toLanguage] + "&dt=t&q=" + URI::encode(toTranslate)
            result = Net::HTTP.get(URI(url))

            translated = JSON.parse(result)[0][0][0]
            <<~HEREDOC
                #{translated} #{flags[toLanguage]}
            HEREDOC
        else
            "https://cdn.memegenerator.es/imagenes/memes/full/22/4/22044287.jpg"
        end
    end

end
