# Based on @hectorpalmatellez's gardel.js

require 'date'
require 'business_time'

def cuando_pagan
  now = Date.today
  month_end = Date.today.end_of_month
  d = now.business_days_until(month_end)
  p = if d > 1
        'n'
      else
        ''
      end

  d == 0 ? '¡Hoy pagan!' : "Falta#{p} #{d} días para que paguen."
end
