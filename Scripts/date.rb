module Time_to
  # Based on @jorgeepunan's 18.js

  def self.september
    x = Date.new(2019, 9, 18)
    y = Time.now.to_date

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
