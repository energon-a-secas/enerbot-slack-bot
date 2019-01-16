# Works somehow
module Resp
  def self.message(data, text, attach = '')
    puts data
    thread = data.ts if data.to_s.include?('thread_ts')

    find = if attach != ''
             json_file = File.read("./Info/#{text}")
             text = ':energon_enterprise:'
             JSON.parse(json_file)[attach]
           else
             []
           end

    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data.channel,
                                       text: text,
                                       icon_url: AccessEval::BOT_ICON,
                                       username: AccessEval::BOT_NAME,
                                       thread_ts: thread,
                                       attachments: find
  end

  def self.write(data, text, thread = '')
    puts data
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data,
                                       text: text,
                                       icon_url: AccessEval::BOT_ICON,
                                       username: AccessEval::BOT_NAME,
                                       thread_ts: thread
  end
end

# If you find yourself in a hole, stop digging
module Case
  def self.bot(data)
    text = data.text
    user = data.user
    if text =~ /(f.q|info|bot[oó]n|activa)/
      Case.events(data)
    else
      # Case definition
      commands = {
          /\s(hello|hola)$/i => '¡Hola!',
          /(c[oó]mo est[aá]s)/i => Quote.status,
          /(help|ayuda)/i => System.help,
          /(consejo|pregunta)(.*?)/i => Quote.advice,
          /un saludo navideño$/i => Macaulay.culkin(user)
      }

      # Definition that doesnt hurt my eyes
      commands.each do |key, value|
        case data.text
        when key then
          @variable = value.to_s
        else
          p 'meh'
        end

      end
      Resp.message(data, @variable) unless @variable.nil?
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
