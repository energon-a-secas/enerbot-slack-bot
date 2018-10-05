module Remote
  def self.control(server, usuario, canal)
    # Plagio de ACL de Bototo
    require 'rubygems'

    admins  = 'CODECHANNEL'
    channel = 'CODECHANNEL'
    $output = if (admins.include? usuario.to_s) && (channel.include? canal.to_s)
                case server
                when /pt/ then
                  'echo ' + server.to_s.split(/\bbot pt \b/) * ''
                when /proce/ then
                  'echo ' + server.to_s.split(/\bbot proce \b/) * ''
                end

  end
  end

  def self.ssh(parsed_command)
    require 'rubygems'
    require 'net/ssh'

    ssh_host = ENV['HOST']
    ssh_user = ENV['USER']
    ssh_pass = ENV['PASS']

    Net::SSH.start(ssh_host, ssh_user, password: ssh_pass) do |ssh|
      ssh.exec!(parsed_command.to_s)
    end
  end
end
