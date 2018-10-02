require 'rubygems'
require 'net/ssh'

HOST = ENV['HOST']
USER = ENV['USER']
PASS = ENV['PASS']

def show(name)
  Net::SSH.start(HOST, USER, password: PASS) do |ssh|
    ssh.exec!(name.to_s)
  end
end
