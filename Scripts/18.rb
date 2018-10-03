# Based on @jorgeepunan's 18.js

def cuanto_falta
  x = Date.new(2019, 9, 18)
  y = Time.now.to_date

  d = (x - y).to_i

  if d == 0
    ':chile: ¡Hoy es 18! ¡A emborracharte!'
  else
    ":chile: Quedan #{d} días pa'l 18 de septiembre."
  end
end
