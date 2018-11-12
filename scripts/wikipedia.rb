# Module for Peyo's security adventures
module Vieja
  def self.sapear(data)
    require 'json'
    require 'net/http'

    frase = data.text.split[2]
    busqueda = JSON.parse(Net::HTTP.get(URI('https://es.wikipedia.org/w/api.php?action=opensearch&search=' + frase +'&limit=10&format=json')))
    
    stringRespuesta = "OPCIONES \n"
    if busqueda.length > 0
        links = busqueda[3]
        iterator = 0;
        links.each{ |x| 
        stringRespuesta += links[iterator]+ "\n"
            iterator += 1
        }
        stringRespuesta += "\n MAS RESPUESTAS EN https://es.wikipedia.org/wiki/"+frase
    else 
        stringRespuesta = "NO HAY RESPUESTAS"
    end
    <<~HEREDOC
        #{stringRespuesta}
    HEREDOC
  end
end