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
    when /hola/i then
      Resp.message(data, '¡Hola!')
    when /(help|ayuda)/i then
      Resp.message(data, System.help)
    when /(c[oó]mo est[aá]s)/i then
      Resp.message(data, Quote.status)
    when /(consejo|pregunta)(.*?)/i then
      Resp.message(data, Quote.advice)
    when /(.*)beneficio/i then
      Resp.message(data, Quote.benefit)
    when /pack$/i then
      Resp.message(data, System.pack)
    when /(rules|reglas)$/i then
      Resp.message(data, System.rules)
    when /cu[aá]ndo pagan/i then
      Resp.message(data, Time_to.gardel)
    when /cu[aá]nto para el 18/i then
      Resp.message(data, Time_to.september)
    when /password/i then
      Resp.message(data, Pass.gen(data))
    when /(blockchain|blocchain|blocshain)/i then
      Resp.message(data, 'https://youtu.be/MHWBEK8w_YY')
    when /info/i then
      Case.events(data)
    when /(tc)/i then
      Resp.message(data, Credit.gen(data))
    when /2fa/i then
      Resp.message(data, Totp.gen(data))
    when /random/i then
      Resp.message(data, Rand.value(data))
    when /pr[oó]ximo feriado$/i
      Resp.message(data, Time_to.holiday_count)
    when /hor[oó]scopo/i
      Resp.message(data, Pedro.engel(data))
    when /dame n[uú]meros para el kino/i
      Resp.message(data, Kino.numeros)
    when /analiza/i
      Resp.message(data, Peyo.check(data))
    when /(faq|fuq)/i
      Case.events(data)
    when /(celery|tayne|oyster|wobble|4d3d3d3|flarhgunnstow)/i
      Resp.message(data, Celery.load(data))
    end
  end

  def self.events(data)
    case data.text
    when /fuq/
      Resp.event(data, 'security.json', 'fuq')
    when /faq/
      Resp.event(data, 'security.json', 'faq')
    when /eventos$/
      Resp.event(data, 'events.json', 'events')
    when /talks$/
      Resp.event(data, 'events.json', 'talks')
    when /tips$/
      Resp.event(data, 'meets.json', 'tips')
    when /enerlive$/
      Resp.event(data, 'events.json', 'events2')
    when /institute$/
      Resp.event(data, 'institute.json', 'degrees')
    end
  end

  def self.say(data)
    if BotValue::BOT_ADMINS.include?(data.user)
      d = data.text.split
      puts d[1].to_s
      puts d[1]
      puts d[1]
      Resp.write(d[1].to_s, d[2..-1].join(' '))
    else
      Resp.write('#bots', d[2..-1].join(' '))
    end
  end
end
