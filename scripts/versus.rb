module Versus
  def self.get
    character = [':godzilla:', ':peyo-blumel:', ':jadue:', ':olla: :ladle:', ':ru:', ':us:', ':peyo2:', ':enerbot-jalowin:', ':oh_hai_mark:', ':emo-peter2:', ':digital-transformation-expert:', ':danilo:']
    selection = character.shuffle!
    "#{selection[1]} :versus: #{selection[2]}"
  end

  def self.tournament
    character = [':godzilla:', ':peyo-blumel:', ':jadue:', ':olla: :ladle:', ':ru:', ':us:', ':peyo2:', ':enerbot-jalowin:', ':oh_hai_mark:', ':emo-peter2:', ':digital-transformation-expert:', ':danilo:']
    contest = character.shuffle![0..3]
    show = "Welcome to the Smash of Security\nOur participants are:\n"
    contest.each { |v| show += "Player: #{v}\n" }

    round1 = contest[0..1].sample
    round2 = contest[2..3].sample
    finals = []
    finals << round1
    finals << round2
    winner = finals.sample

    show += "First round: #{contest[0]} vs #{contest[1]}\n"
    show += "Second round: #{contest[2]} vs #{contest[3]}\n"
    show += "Final round: #{round1} vs #{round2}\n"
    show += "WINNER: #{winner}"
  end
end
