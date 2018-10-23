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
    client.web_client.chat_postMessage as_user: true,
                                       channel: data.channel,
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
    text = data.text.to_s.split(/\benerbot/) * ''
    case text
    when /hola/i then
      Resp.message(data, '¡Hola!')
    when /(va|estas)/i then
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
      Resp.message(data, rand(36 ** 36).to_s(36))
    when /(blockchain|blocchain|blocshain)/i then
      Resp.message(data, 'https://www.youtube.com/watch?v=MHWBEK8w_YY')
    when /info/i then
      Case.events(data)
    end
    end

  def self.events(data)
    case data.text
    when /How/
      Resp.event(data, 'example.json', 'attachments')
    when /eventos$/
      Resp.event(data, 'events.json', 'events')
    when /talks$/
      Resp.event(data, 'events.json', 'talks')
    end
  end

  def self.say(data)
    text = data.text.to_s.split(/\benersay/) * ''
    Resp.write('C3W4PHU7K', text)
  end
end
