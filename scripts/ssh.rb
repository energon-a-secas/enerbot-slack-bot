require 'rubygems'
require 'net/ssh'

# Works with the power of friendship
module Remote
  def self.ssh(data)
    text = data.text.to_s.split(/\benerssh/) * ''
    Net::SSH.start(BotValue::HOST_SSH, BotValue::USER_SSH, password: BotValue::PASS_SSH) do |ssh|
      ssh.exec!(text.to_s)
    end
  end
end
