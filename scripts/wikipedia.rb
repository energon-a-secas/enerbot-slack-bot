# Module for Peyo's security adventures
module Vieja
  def self.sapear(text)
    require 'json'
    require 'net/http'

    frase = text.split[2]
    uri = "https://es.wikipedia.org/w/api.php?action=opensearch&search=#{frase}"
    uri += '&limit=10&format=json'

    busqueda = JSON.parse(Net::HTTP.get(URI(uri)))

    string_respuesta = "OPCIONES \n"
    if !busqueda.empty?
      links = busqueda[3]
      iterator = 0
      links.each do |_x|
        string_respuesta += links[iterator] + "\n"
        iterator += 1
      end
      string_respuesta += "\nMAS RESPUESTAS EN "
      string_respuesta += "https://es.wikipedia.org/wiki/#{frase}"
    else
      string_respuesta = 'NO HAY RESPUESTAS'
    end
    <<-HEREDOC
        #{string_respuesta}
    HEREDOC
  end
end
