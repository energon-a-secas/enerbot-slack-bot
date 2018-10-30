module Time_to
  # Based on @jorgeepunan's 18.js

  def self.september
    y = Date.today
    year = y.strftime("%Y").to_i
    if (y.strftime("%-m").to_i == 9 and y.strftime("%-d").to_i > 18) || (y.strftime("%-m").to_i > 9)
      year += 1
    end

    x = Date.new(year, 9, 18)

    d = (x - y).to_i

    f = d == 1 ? "Falta #{d} día" : "Faltan #{d} días"
    d == 0 ? ":chile: ¡Hoy es 18! ¡A emborracharte!." : ":chile: #{f} pa'l 18 de septiembre."
  end

  # Based on @hectorpalmatellez's gardel.js

  def self.gardel
    require 'week_of_month'

    date = Date.parse(Date.today.to_s)
    last = Date.parse(date.end_of_month.downto(date).find(&:working_day?).to_s)
    d = last.mjd - date.mjd - 2
    p = date.mjd > 1 ? "Faltan #{d} días" : "Falta #{d} día"

    d == 0 ? '¡Hoy pagan!' : "#{p} para que paguen."
  end

  # Based con @victorsanmartin's proximo-feriado.js
  def self.holidays_count
    holidays = JSON.parse(Net::HTTP.get(URI('https://www.feriadosapp.com/api/holidays.json')))
    
    message = "No hay feriados :thinking: :scream:"

    holidays['data'].each do |holiday|
      countdown = (Date.parse(holiday['date']) - Date.today).to_i
      laws = holiday['law'].join(" - ").downcase
      if countdown == 0
        message = "Hoy es feriado en :chile:, se celebra *#{holiday['title']}* (feriado #{holiday['extra'].downcase}, declarado por #{laws})"
        break
      elsif countdown > 0
        plural = countdown > 1 ? "s" : ""
        message = "Próximo feriado en :chile: es en #{countdown} día#{plural} (#{holiday['date']}), se celebra *#{holiday['title']}* (feriado #{holiday['extra'].downcase}, declarado por #{laws})"  
        break
      end
    end
    
    return message
  end
end
