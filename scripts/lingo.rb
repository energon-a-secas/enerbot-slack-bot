require 'json'
require 'net/http'
require 'uri'

module Lingo
  
  def self.translate(data)
      languages =  {"ingles" => "en", "español" => "es", "frances" => "fr", "portugues" => "pt", "ruso" => "ru",
      "chino" => "zh", "japones" => "ja", "italiano" => "it", "argentino" => "es", "chileno" => "es", "brasileño" => "pt"}

      flags =  {"ingles" => ":uk:", "español" => ":es:", "frances" => ":fr:", "portugues" => ":flag-pt:", "ruso" => ":ru:",
      "chino" => ":flag-cn:", "japones" => ":jp:", "italiano" => ":it:", "argentino" => ":ar:", "chileno" => ":flag-cl:", "brasileño" => ":flag-br:"}

      params = data.split(' en ')
      if languages.keys.include? params[1]
        url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=" + languages[params[1]] + "&dt=t&q=" + URI::encode(params[0]);
        result = Net::HTTP.get(URI(url))

        translated = JSON.parse(result)[0][0][0]
        <<~HEREDOC
          #{translated} #{flags[params[1]]}
        HEREDOC
      else
        "https://cdn.memegenerator.es/imagenes/memes/full/22/4/22044287.jpg"
      end

  end

end
