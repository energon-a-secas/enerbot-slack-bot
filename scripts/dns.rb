# Module for dns
module Check
  def self.dns(text)
    require 'net/dns'

    host = 'google.com'
    if (match = text.match(/dig (ns|cname|a|mx|txt|soa) ((.*)\|)?(.*?)(\>)?$/i))
      host = match.captures[3]
      record = match.captures[0]
    end
    reco = record
    ans = case reco
          when /ns/i
            Resolver(host, Net::DNS::NS)
          when /cname/i
            Resolver(host, Net::DNS::CNAME)
          when /mx/i
            Resolver(host, Net::DNS::MX)
          when 'a', 'A'
            Resolver(host, Net::DNS::A)
          when /txt/i
            Resolver(host, Net::DNS::TXT)
          when /soa/i
            Resolver(host, Net::DNS::SOA)
          end
    "```#{ans}```"
  end

  def self.regis(text)
    require 'whois-parser'

    host = 'google.com'
    if (match = text.match(/whois ((.*)\|)?(.*?)(\>)?$/i))
      host = match.captures[3]
    end

    domain = host
    record = Whois.whois(domain)
    parser = record.parser
    avail = parser.available?
    regis = parser.registered?

    creat = parser.created_on
    tech = parser.technical_contacts.first

    p <<-HEREDOC
:earth_americas: Información sobre el dominio #{domain}

*Registrado:* #{regis}
*Creado:* #{creat}
*Disponible:* #{avail}

*Name:* #{tech.name}
*Organization:* #{tech.organization}
*Address:* #{tech.address}
*Email:* #{tech.email}
    HEREDOC
  end
end
