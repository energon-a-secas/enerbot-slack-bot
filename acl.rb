# Plagio de ACL de Bototo
require 'rubygems'

ADMINS = %w[ABCDEFG1 ABCDE123].freeze
CHANNEL = %w[ASD123ASD ASD123123].freeze

def control(server, usuario, canal)
  $output = if (ADMINS.include? usuario.to_s) && (CHANNEL.include? canal.to_s)
              case server
              when /pt/ then
                'echo ' + server.to_s.split(/\bbot pt \b/) * ''
              when /proce/ then
                'echo ' + server.to_s.split(/\bbot proce \b/) * ''
              end

            end
end
