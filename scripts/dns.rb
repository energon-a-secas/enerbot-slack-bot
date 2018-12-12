# Module for dns
module Check
  def self.dns(text)
    require 'net/dns'

    host = 'google.com'
    if (match = text.match(/dig (ns|cname) ((.*)\|)?(.*?)(\>)?$/i))
      host = match.captures[3]
      record = match.captures[0]
    end
    reco = record
    ans = case reco
          when /ns/i
            Resolver(host, Net::DNS::NS)
          when /cname/i
            Resolver(host, Net::DNS::CNAME)
          end
    "```#{ans}```"
  end
end