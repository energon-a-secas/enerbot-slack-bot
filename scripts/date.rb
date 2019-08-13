require 'week_of_month'
require 'json'
require 'net/http'
require 'holidays'
require 'countries'

# Module for time related scripts
module TimeTo
  # Based on @jorgeepunan's 18.js
  def self.september
    y = Date.today
    year = y.strftime('%Y').to_i
    if ((y.strftime('%-m').to_i == 9) && (y.strftime('%-d').to_i > 18)) ||
       (y.strftime('%-m').to_i > 9)
      year += 1
    end

    x = Date.new(year, 9, 18)

    d = (x - y).to_i

    f = d == 1 ? "Falta #{d} día" : "Faltan #{d} días"
    if d.zero?
      ':chile: ¡Hoy es 18! ¡A emborracharte!.'
    else
      ":chile: #{f} pa'l 18 de septiembre."
    end
  end

  # Based on @hectorpalmatellez's gardel.js
  def self.gardel
    date = Date.parse(Date.today.to_s)
    last = Date.parse(date.end_of_month.downto(date).find(&:working_day?).to_s)
    d = last.mjd - date.mjd - 2
    message = '¡Hoy pagan!'
    if d < 0
      message = "Pagaron hace #{d.abs} día(s). ¿No te llegó el depósito? Uf..."
    elsif d > 0
      message = d == 1 ? "Falta #{d} día" : "Faltan #{d} días"
      message += ' para que paguen.'
    end

    <<-HEREDOC
    #{message}
    HEREDOC
  end

  # Get holidays by country code
  def self.holiday_count(text)
    country = ''

    if (match = text.match(/pr[óo]ximo feriado (.*?)$/i))
      country = match.captures[0]
    end

    c = ISO3166::Country.find_country_by_name(country)

    holiday = begin
        Holidays.next_holidays(1, [c.alpha2.downcase, :observed])
              rescue StandardError
                nil
      end

    if holiday.nil?
      message = "No puedo obtener feriados para *#{country}*"
    else
      countdown = (holiday[0][:date] - Date.today).to_i
      if countdown.zero?
        message = "Hoy es feriado en :flag-#{c.alpha2.downcase}:, se celebra *\"#{holiday[0][:name]}\"* "
      elsif countdown > 0
        plural = countdown > 1 ? 's' : ''
        message = "Próximo feriado en :flag-#{c.alpha2.downcase}: es en #{countdown} día#{plural} "
        message += "(#{holiday[0][:date].strftime('%Y-%m-%d')}), se celebra *\"#{holiday[0][:name]}\"* "
      else
        message = "No hay feriados para :flag-#{c.alpha2.downcase}: :thinking: :scream:"
      end
    end

    <<-HEREDOC
#{message}
    HEREDOC
  end

  def self.progress(text, user)
    case text
    when /softlayer/
      "#{(Date.parse('4/8/2019')..Date.today).count} días y contando."
    else
      "No sé a que te refieres <@#{user}> :softlayer: :heart:"
    end
  end
end
