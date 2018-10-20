# Works somehow
module Resp
  def self.message(data, text)
    puts data
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data.channel,
                                       text: text,
                                       icon_emoji: BOT_ICON,
                                       username: BOT_NAME
  end

  def self.event(data, path, attachments)
    puts data
    read_file = File.read("./Info/#{path}")
    ex_json = JSON.parse(read_file)
    attachments = ex_json[attachments]
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage as_user: true,
                                       channel: data.channel,
                                       text: 'Revisando mi BD :buffer:',
                                       icon_emoji: BOT_ICON,
                                       username: BOT_NAME,
                                       attachments: attachments
  end

  def self.write(data, text)
    client = Slack::RealTime::Client.new
    client.web_client.chat_postMessage channel: data,
                                       text: text,
                                       icon_emoji: BOT_ICON,
                                       username: BOT_NAME
  end
end

# It should look like this
module Case
  def self.bot(data)
    text = data.text.to_s.split(/\benerbot/) * ''
    case text
    when /hola/i then
      Resp.message(data, '¡Hola!')
    when /(va|estas)$/i then
      Resp.message(data, Quote.status)
    when /(consejo|pregunta)(.*?)/i then
      Resp.message(data, Quote.advice)
    when /(.*)beneficio/i then
      Resp.message(data, Quote.benefit)
    when /(.*)pack/i then
      Resp.message(data, Info.pack)
    when /\s(.*)\s(rules|reglas)$/i then
      Resp.message(data, Info.rules)
    when /cu[aá]ndo pagan?/i then
      Resp.message(data, Time_to.gardel)
    when /cu[aá]nto para el 18?/i then
      Resp.message(data, Time_to.september)
    when /info/i then
      if data.text.include? 'How'
        Resp.event(data, 'example.json', 'attachments')
      elsif data.text.include? 'enerconf talks'
        Resp.event(data, 'enerconf.json', 'talks')
      else
        Resp.event(data, 'enerconf.json', 'attachments')
      end
    when 'self-destruct' then
      if bot_admin.include? data.user
        Resp.message(data, 'Bye')
        abort('bye')
      else
        Resp.message(data, 'Meh')
      end
    end
  end

  def self.say(data)
    text = data.text.to_s.split(/\benersay/) * ''
    Resp.write('GD8172Q22', text)
  end
end
