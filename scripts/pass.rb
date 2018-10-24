module Pass
  def self.gen(data)
    require 'passgen'
    if data.text.include? 'sec'
      Passgen::generate(:symbols => true, :length => 36, :digits_before => 3)
    else
      "#{rand(36 ** 36).to_s(36)}!"
    end
  end
end