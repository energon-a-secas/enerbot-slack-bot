# Module for stuff related to lotery
module Lotery
  def self.num
    k = (1..25).to_a.shuffle!
    p = (1..100).to_a.shuffle!
    n = k[0..13].sort.join(', ')
    p ":crystal_ball: Números: #{n} \n #{Lotery.status(p[0])} Probabilidad de ganar: #{p[0]}%"
  end

  def self.status(per)
    case per
    when 1..10
      ':thunder_cloud_and_rain:'
    when 11..20
      ':rain_cloud:'
    when 21..30
      ':cloud:'
    when 31..40
      ':partly_sunny:'
    when 41..49
      ':mostly_sunny:'
    when 50
      ':partly_sunny_rain:'
    when 51..70
      ':sunny:'
    when 71..80
      ':full_moon_with_face:'
    when 81..99
      ':rainbow:'
    when 100
      ':newalert:'
    end
  end

  def self.winnerNums
    require 'nokogiri'
    require 'open-uri'

    doc = Nokogiri::HTML(open('https://losresultados.info/kino/'))
    title = doc.search('.entry-title').inner_text.to_s
    nums = doc.search('table').first.inner_text.to_s
    p <<-HEREDOC
#{title}
:trophy: *Números:* #{nums.scan(/../).join(', ')}.
    HEREDOC
  end
end
