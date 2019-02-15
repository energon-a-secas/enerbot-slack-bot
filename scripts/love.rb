# Module that generates love for the people
module Love
  def self.me
    if Date.today != '14-02'
      [
        'Hoy no es el día que te toca :badjoke:',
        'Para ti hoy no, intenta de nuevo el 31 de Octubre :ghost:',
        'Hoy no estoy de ánimos, mi machine learning perdió carisma :broken_heart:',
        'Creo que hoy tu deberías darme amor a mi :smirk:',
        'Me preguntaste qué era el amor y no te supe contestar. Ahora sé que es un sentimiento que no se puede dominar :pogsad:',
        'Quiero amarte en silencio. Realmente en silencio, sin que me hables más :badjoke:',
        'Deberías llamarte google, porque en ti está todo lo que busco. Humano :enerbot-love:',
        'Estai más ric@ que sopaipillas en domingo de lluvia :danilo:'
      ].sample
    else
      ':tinder:'
    end
  end
end
