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
    case data.text
    when /\s(hello|hola)$/i
      z = '¡Hola!'
    when /(help|ayuda)/i
      z = System.help
    when /(c[oó]mo est[aá]s)/i
      z = Quote.status
    when /(consejo|pregunta)(.*?)/i
      z = Quote.advice
    when /(.*)beneficio/i
      z = Quote.benefit
    when /pack$/i
      z = System.pack
    when /(rules|reglas)$/i
      z = System.rules
    when /cu[aá]ndo pagan/i
      z = Time_to.gardel
    when /cu[aá]nto para el 18/i
      z = Time_to.september
    when /password/i
      z = Pass.gen(data)
    when /(blockchain|blocchain|blocshain)/i
      z = 'https://youtu.be/MHWBEK8w_YY'
    when /info/i
      Case.events(data)
    when /(tc)/i
      z = Credit.gen(data)
    when /2fa/i
      z = Totp.gen(data)
    when /random/i
      z = Rand.value(data)
    when /pr[oó]ximo feriado$/i
      z = Time_to.holiday_count
    when /hor[oó]scopo/i
      z = Pedro.engel(data)
    when /dame n[uú]meros para el kino/i
      z = Lotery.num
    when /analiza/i
      z = Peyo.check(data)
    when /(faq|fuq)/i
      Case.events(data)
    when /(celery|tayne|oyster|wobble|4d3d3d3|flarhgunnstow)/i
      z = Celery.load(data)
    when /c[oó]mo se dice/i
      z = Lingo.translate(data)
    when /resultados kino/
      z = Lotery.winnerNums
    when /(valor acci[óo]n (.*?)$)/i
      z = Stock.fetch(data.text)
    when /qr/i
      z = QR.generate(data.text)
    when /wikipedia/i
      z = Vieja.sapear(data)
    when /vuelo/i
      z = Flight.info(data.text)
    when /clima/i
      z = Ivan.torres(data.text)
    end

    Resp.message(data, z)
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

# Meh
module Events
  def self.events(data)
    as = [{ file: 'security.json', op1: 'fuq', op2: 'faq' },
          { file: 'events.json', op1: 'events', op2: 'events2', op3: 'talks' },
          { file: 'institute.json', op1: 'degrees', op2: 'talks' },
          { file: 'meets.json', op1: 'tips' },
          { file: 'contest.json', op1: 'general', op2: 'SDSOS', op3: 'design' }]

    case data.text
    when /fuq/ then y = as[0][:file]
                    z = as[0][:op1]
    when /faq/ then y = as[0][:file]
                    z = as[0][:op2]
    when /eventos$/ then y = as[1][:file]
                         z = as[1][:op1]
    when /talks$/ then y = as[1][:file]
                       z = as[1][:op3]
    when /tips$/ then y = as[3][:file]
                      z = as[3][:op1]
    when /enerlive$/ then y = as[1][:file]
                          z = as[1][:op2]
    when /institute$/ then y = as[2][:file]
                           z = as[2][:op2]
    when /contest general_info$/ then y = as[4][:file]
                                      z = as[4][:op1]
    when /contest SDSOS$/ then y = as[4][:file]
                               z = as[4][:op2]
    when /contest diseña$/ then y = as[4][:file]
                                z = as[4][:op3]
    end

    Resp.event(data, y, z)
  end
end
