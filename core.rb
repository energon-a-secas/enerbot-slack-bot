# Works somehow
module Resp
  def self.message(data, text, attach = nil)
    puts data
    thread = data.ts if data.to_s.include?('thread_ts')

    find = unless attach.nil?
             json_file = File.read("./Info/#{text}")
             text = nil
             JSON.parse(json_file)
    end

    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data.channel,
                                       text: text,
                                       icon_url: AccessEval::BOT_ICON,
                                       username: AccessEval::BOT_NAME,
                                       thread_ts: thread,
                                       attachments: find["#{attach}"]
  end

  def self.write(data, text)
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data,
                                       text: text,
                                       icon_url: AccessEval::BOT_ICON,
                                       username: AccessEval::BOT_NAME
  end
end

# If you find yourself in a hole, stop digging
module Case
  def self.bot(data)
    text = data.text
    if text =~ /(f.q|info|bot[oó]n|activa)/
      Case.events(data)
    else
      mess = case text
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
               TimeTo.gardel
             when /cu[aá]nto para el 18/i
               TimeTo.september
             when /password/i
               Pass.gen(text)
             when /(blockchain|blocchain|blocshain)/i
               'https://youtu.be/MHWBEK8w_YY'
             when / tc /i
               Credit.gen(text)
             when /2fa/i
               Totp.gen(text)
             when /random/i
               Rand.value(text)
             when /pr[oó]ximo feriado$/i
               TimeTo.holiday_count
             when /hor[oó]scopo/i
               Pedro.engel(text)
             when /dame n[uú]meros para el kino/i
               Lotery.num
             when /analiza/i
               Peyo.check(text)
             when /(celery|tayne|oyster|wobble|4d3d3d3|flarhgunnstow)/i
               Celery.load(text)
             when /c[oó]mo se dice/i
               Lingo.translate(text)
             when /resultados kino/
               Lotery.winner_nums
             when /(valor acci[óo]n (.*?)$)/i
               Stock.fetch(text)
             when /wikipedia/i
               Vieja.sapear(text)
             when /vuelo/i
               Flight.info(text)
             when /clima/i
               Ivan.torres(text)
             when /cve list/i
               CVE.latest(text)
             when /dame una excusa$/i
               RicardoCanitrot.getexcuse
             when /una frase para el bronce$/i
               Bronze.quote
             when /un saludo navideño$/i
               Macaulay.culkin(data.user)
             when /haarp/i
               Haarp.terre
             when /amigo secreto/i
               SecretFriend.generate(data.text)
             when / dig /i
               Check.dns(text)
             when / whois /i
               Check.regis(text)
             when / pwned email /i
               HIBP.check_email(text)
             when /commit/i
               Quote.commit
             when /trace/i
               Check.trace(text)
             when /is the internet on fire\?$/i
               Internet.onfire
             when /acme catalog$/i
               Acme.catalog
             when /santo sepulcro a/i
               Chimuelo.song(data.text, data.user)
             end
      Resp.message(data, mess) unless mess.nil?
    end
  end

  def self.events(data)
    dc = [{ file: 'security.json', op1: 'fuq', op2: 'faq' },
          { file: 'events.json', op1: 'events', op2: 'events2', op3: 'talks' },
          { file: 'institute.json', op1: 'degrees', op2: 'talks' },
          { file: 'meets.json', op1: 'tips' },
          { file: 'contest.json', op1: 'general', op2: 'SDSOS', op3: 'design' },
          { file: 'buttons.json', op1: 'flight', op2: 'legacy', op3: 'last_resort', op4: 'energon' },
          { file: 'daily.json', op1: 'docs', op2: 'report' }]

    file, info = case data.text
                 when /fuq/
                   [0, :op1]
                 when /faq/
                   [0, :op2]
                 when /eventos$/
                   [1, :op1]
                 when /talks$/
                   [1, :op3]
                 when /tips$/
                   [3, :op1]
                 when /enerlive$/
                   [1, :op2]
                 when /institute$/
                   [2, :op2]
                 when /contest general_info$/
                   [4, :op1]
                 when /contest SDSOS$/
                   [4, :op2]
                 when /contest diseña$/
                   [4, :op3]
                 when /(flight|vuelo)/
                   [5, :op1]
                 when /(legacy|kill)/
                   [5, :op2]
                 when /(panic|panico)/
                   [5, :op3]
                 when /(energon|empresa)/
                   [5, :op4]
                 when /daily/
                   [6, :op1]
                 when /report/
                   [6, :op2]
                 end
    mess = dc[file]
    Resp.message(data, mess[:file], mess[info])
  end

  def self.kill(text)
    case text
    when 'enershut'
      System.kill
    when 'お前もう死んでいる'
      Quote.japanese
    end
  end
end
