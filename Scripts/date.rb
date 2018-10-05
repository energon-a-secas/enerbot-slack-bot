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
    require 'date'
    require 'business_time'
    now = Date.today
    month_end = Date.today.end_of_month
    d = now.business_days_until(month_end)
    p = if d > 1
          'n'
        else
          ''
        end

    d == 0 ? '¡Hoy pagan!' : "Falta#{p} #{d} días hábiles para que paguen."
  end
end
