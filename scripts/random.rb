#Fair and square
module Rand
  def self.value(data)
    person = data.text.split[3]
    "Resultado: #{person}"
  end
end
