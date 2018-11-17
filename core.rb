# Works somehow
module Resp
  def self.message(data, text)
    puts data
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data.channel,
                                       text: text,
                                       icon_emoji: BotValue::BOT_ICON,
                                       username: BotValue::BOT_NAME
  end

  def self.event(data, path, attachments)
    puts data
    json_file = File.read("./Info/#{path}")
    parsed_file = JSON.parse(json_file)
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data.channel,
                                       text: Quote.search,
                                       icon_emoji: BotValue::BOT_ICON,
                                       username: BotValue::BOT_NAME,
                                       attachments: parsed_file[attachments]
  end

  def self.write(data, text)
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data,
                                       text: text,
                                       icon_emoji: BotValue::BOT_ICON,
                                       username: BotValue::BOT_NAME
  end
end

# If you find yourself in a hole, stop digging
module Case
  def self.bot(data)
    z = case data.text
        when /\s(hello|hola)$/i
          '¡Hola!'
        when /(help|ayuda)/i
          System.help
        when /(c[oó]mo est[aá]s)/i
          Quote.status
        when /(consejo|pregunta)(.*?)/i
          Quote.advice
        when /(.*)beneficio/i
          Quote.benefit
        when /pack$/i
          System.pack
        when /(rules|reglas)$/i
          System.rules
        when /cu[aá]ndo pagan/i
          Time_to.gardel
        when /cu[aá]nto para el 18/i
          Time_to.september
        when /password/i
          Pass.gen(data)
        when /(blockchain|blocchain|blocshain)/i
          'https://youtu.be/MHWBEK8w_YY'
        when /info/i
          Case.events(data)
        when /(tc)/i
          Credit.gen(data)
        when /2fa/i
          Totp.gen(data)
        when /random/i
          Rand.value(data)
        when /pr[oó]ximo feriado$/i
          Time_to.holiday_count
        when /hor[oó]scopo/i
          Pedro.engel(data)
        when /dame n[uú]meros para el kino/i
          Lotery.num
        when /analiza/i
          Peyo.check(data)
        when /(faq|fuq)/i
          Case.events(data)
        when /(celery|tayne|oyster|wobble|4d3d3d3|flarhgunnstow)/i
          Celery.load(data)
        when /c[oó]mo se dice/i
          Lingo.translate(data)
        when /resultados kino/
          Lotery.winnerNums
        when /(valor acci[óo]n (.*?)$)/i
          Stock.fetch(data.text)
        when /qr/i
          QR.generate(data.text)
        when /wikipedia/i
          Vieja.sapear(data)
        when /vuelo/i
          Flight.info(data.text)
        when /clima/i
          Ivan.torres(data.text)
        end
    Resp.message(data, z)
  end

  def self.events(data)
    as = [{ file: 'security.json', op1: 'fuq', op2: 'faq' },
          { file: 'events.json', op1: 'events', op2: 'events2', op3: 'talks' },
          { file: 'institute.json', op1: 'degrees', op2: 'talks' },
          { file: 'meets.json', op1: 'tips' },
          { file: 'contest.json', op1: 'general', op2: 'SDSOS', op3: 'design' }]

    y, z = case data.text
           when /fuq/
             [(as[0][:file]).to_s, (as[0][:op1]).to_s]
           when /faq/
             [(as[1][:file]).to_s, (as[1][:op2]).to_s]
           when /eventos$/
             [(as[1][:file]).to_s, (as[1][:op1]).to_s]
           when /talks$/
             [(as[1][:file]).to_s, (as[1][:op2]).to_s]
           when /tips$/
             [(as[3][:file]).to_s, (as[3][:op1]).to_s]
           when /enerlive$/
             [(as[1][:file]).to_s, (as[1][:op2]).to_s]
           when /institute$/
             [(as[2][:file]).to_s, (as[2][:op2]).to_s]
           when /contest general_info$/
             [(as[4][:file]).to_s, (as[4][:op1]).to_s]
           when /contest SDSOS$/
             [(as[4][:file]).to_s, (as[4][:op2]).to_s]
           when /contest diseña$/
             [(as[4][:file]).to_s, (as[4][:op3]).to_s]
           end

    Resp.event(data, y, z)

  end

  def self.say(data)
    if BotValue::BOT_ADMINS.include?(data.user)
      d = data.text.split
      Resp.write(d[1].to_s, d[2..-1].join(' '))
    else
      Resp.write('#bots', d[2..-1].join(' '))
    end
  end
end
