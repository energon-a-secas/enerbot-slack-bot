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
end