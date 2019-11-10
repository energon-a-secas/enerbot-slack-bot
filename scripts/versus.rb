module Versus
  def self.get
    character = [':godzilla:', ':peyo-blumel:', ':jadue:', ':olla: :ladle:', ':ru:', ':us:', ':peyo-hd:', ':enerbot-jalowin:', ':tepillamos:', ':emo-peter2:', ':digital-transformation-expert:', ':danilo:']
    selection = character.shuffle!
    "#{selection[1]} :versus: #{selection[2]}"
  end

  def self.tournament
    character = [':godzilla:', ':peyo-blumel:', ':jadue:', ':olla: :ladle:', ':ru:', ':us:', ':peyo-hd:', ':elbromas:', ':enerbot-jalowin:', ':tepillamos:', ':emo-peter2:', ':celery_dancer:', ':digital-transformation-expert:', ':danilo:']
    contest = character.shuffle![0..3]
    show = ":announcer:: *Welcome to the Security Smash Tournament :final-smash: Our competitors are:* \n\n"
    contest.each { |v| show += "- #{v}\n" }

    round1 = contest[0..1].sample
    round2 = contest[2..3].sample
    finals = []
    finals << round1
    finals << round2
    winner = finals.sample

    show += "\n*First round:*\n#{contest[0]} :versus3: #{contest[1]} => #{round1}\n"
    show += "\n*Second round:*\n#{contest[2]} :versus3: #{contest[3]} => #{round2}\n"
    show += "\n*Final round:* #{round1} :versus3: #{round2}\n"
    show += "\n:crown: *WINNER OF THE TOURNAMENT*: #{winner}"
  end
end
