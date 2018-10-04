module Info
  def self.rules
    <<~RULES
   0. A robot may not harm humanity, or, by inaction, allow humanity to come to harm.
   1. A robot may not injure a human being or, through inaction, allow a human being to come to harm.
   2. A robot must obey any orders given to it by human beings, except where such orders would conflict with the First Law.
   3. A robot must protect its own existence as long as such protection does not conflict with the First or Second Law.
   4. CLASSIFIED.
    RULES
  end
end

module Quote
  def self.advice
    ['En mi opinión, sí',
     'Es cierto',
     'Es decididamente así',
     'Probablemente',
     'Buen pronóstico',
     'Todo apunta a que sí',
     'Sin duda',
     'Sí',
     'Sí - definitivamente',
     'Debes confiar en ello',
     'Respuesta vaga, vuelve a intentarlo',
     'Pregunta en otro momento',
     'Será mejor que no te lo diga ahora',
     'No puedo predecirlo ahora',
     'Concéntrate y vuelve a preguntar',
     'No cuentes con ello',
     'Mi respuesta es no',
     'Mis fuentes me dicen que no',
     'Las perspectivas no son buenas',
     'Muy dudoso'].sample
  end

  def self.benefit
    ['Tómate la tarde libre, proletario.',
     '¡4 semanas de vacaciones pagadas!',
     'Escoje el computador y la silla que quieras.',
     'Snacks, café, frutas y bebidas libre todos los días todo el día.',
     'Aguinaldo en septiembre y diciembre.',
     'Bono anual por metas cumplidas.',
     'Seguro de salud y dental para ti y tu familia.',
     'Bono anual sólo por ser un :energon: dev',
     'Permisos para celebrar y compartir en la :energon: Conf'].sample
  end

  def self.music
    %w[https://youtu.be/z5OXON8vIaA
       https://youtu.be/M-iXzPkgNpw?t
       https://youtu.be/Q91hydQRGyM?t
       https://youtu.be/HSh73d3TZcA
       https://youtu.be/D_P-v1BVQn8
       https://youtu.be/sFrNsSnk8GM].sample
  end
end

module Time_to
  def self.september
    x = Date.new(2019, 9, 18)
    y = Time.now.to_date

    d = (x - y).to_i

    if d == 0
      return ':chile: ¡Hoy es 18! ¡A emborracharte!'
    else
      return ":chile: Quedan #{d} días pa'l 18 de septiembre."
    end
  end

  def self.gardel
    require 'date'
    require 'business_time'
    now = Date.today
    month_end = Date.today.end_of_month
    d = now.business_days_until(month_end)
    p = if d > 1
          'n'
        else
          ''
        end

    d == 0 ? '¡Hoy pagan!' : "Falta#{p} #{d} días para que paguen."
  end
end


module Slack
  require 'slack-ruby-client'

  def self.run
    Slack.configure do |config|
      config.token = ENV['SLACK_API_TOKEN']
      config.raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
    end

    client = Slack::RealTime::Client.new

    client.on :hello do
      puts "Successfully connected, welcome '#{client.self.name}' to the '#{client.team.name}' team at https://#{client.team.domain}.slack.com."
    end

    client.on :message do |data|
      puts data
      if 'DBDH58JJU'.include? data.channel
        case data.text
        when 'enerbotv hola' then
          client.web_client.chat_postMessage channel: data.channel, text: '¡Hola!', icon_emoji: ':black_square:', username: 'ENERBOT'
        when /enerbotb como va/ then
          client.web_client.chat_postMessage channel: data.channel, text: 'Trabajo muy duro, como un esclavo... :musical_note:', icon_emoji: ':black_square:', username: 'ENERBOT'
        when /enerbotb un consejo/, /enerbot una pregunta/ then
          client.web_client.chat_postMessage channel: data.channel, text: Quote.advice, icon_emoji: ':black_square:', username: 'ENERBOT'
        when 'enerbot cuando pagan?'then
          client.web_client.chat_postMessage channel: data.channel, text: Time_to.gardel, icon_emoji: ':black_square:', username: 'ENERBOT'
        when 'enerbot las reglas', 'enerbot da rules', /enerbot the rules/ then
          client.web_client.chat_postMessage channel: data.channel, text: Info.rules, icon_emoji: ':black_square:', username: 'ENERBOT'
        when 'self-destruct' then
          abort('Bye')
        end
      else
        case data.text
        when /enerbotv como va/ then
          client.web_client.chat_postMessage channel: data.channel, text: Quote.advice, icon_emoji: ':black_square:', username: 'ENERBOT'

        end
      end
    end
    client.start!
  end
end

