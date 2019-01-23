# Tira un dado
module Roleo
  def self.dados(text)
    if (match = text.match(/roll (\d+) (\d+)/i))
      dice = match.captures[0].to_i

      number = match.captures[1].to_i
      face = if number.even?
               results = ''
               p number
             else
               results = "You number #{number.to_s} has been increased by 1 :gandalf:\n"
               p number.next
             end
    end

    total = 0
    min = ''
    max = ''


    if dice > 20
      ":game_die: #{dice} es un cantidad absurda, prueba con otra"
    else
      (1..dice).each do |i|
        result = (1..face).to_a
        min = result.min
        max = result.max
        num = result.shuffle![3]
        total += num
        results += "\n*:game_die: Dado #{i}:* #{num}"
      end
      p "*Results:* #{results}\nSuming a total of *#{total}* :gandalf_parrot: \n*Minimum rolled number:* #{min}\n*Maximum rolled number:* #{max} "
    end

  end
end
