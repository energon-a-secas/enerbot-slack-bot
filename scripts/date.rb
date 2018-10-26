module Time_to
  # Based on @jorgeepunan's 18.js

  def self.september
    y = Date.today
    year = y.strftime("%Y").to_i;
    if (y.strftime("%-m").to_i == 9 and y.strftime("%-d").to_i > 18) || (y.strftime("%-m").to_i > 9)
      year += 1
    end

    x = Date.new(year, 9, 18)

    d = (x - y).to_i

    if d == 0
      return ':chile: ¡Hoy es 18! ¡A emborracharte!'
    else
      return ":chile: Quedan #{d} días pa'l 18 de septiembre."
    end
  end

  # Based on @hectorpalmatellez's gardel.js

  def self.gardel
    require 'week_of_month'

    date = Date.parse(Date.today.to_s)
    last = Date.parse(date.end_of_month.downto(date).find(&:working_day?).to_s)
    d = last.mjd - date.mjd - 2
    p = if date.mjd > 1
          'n'
        else
          ''
        end

    d == 0 ? '¡Hoy pagan!' : "Falta#{p} #{d} días para que paguen."
  end
end
