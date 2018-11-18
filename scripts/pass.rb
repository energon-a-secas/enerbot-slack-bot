# Module that generates a password and sometimes it's secure
module Pass
  def self.gen(text)
    require 'passgen'

    if text.include? 'sec'
      Passgen.generate(symbols: true, length: 36, digits_before: 3)
    else
      "#{rand(36**36).to_s(36)}!"
    end
  end
end
