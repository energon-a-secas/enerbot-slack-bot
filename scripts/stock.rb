require 'json'
require 'net/http'
require 'uri'
require 'stock_quote'

# Module for bussiness
module Stock
  def self.fetch(text)
    search = ''
    message = ''
    if (match = text.match(/valor acci[oó]n (.*?)$/i))
      search = match.captures[0]
    end
    if search && search !~ /energon/i
      uri = "http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=#{search}&region=1&lang=en&callback=YAHOO.Finance.SymbolSuggest.ssCallback"
      result_set = Net::HTTP.get(URI(uri)).match(/YAHOO.Finance.SymbolSuggest.ssCallback\((.*?)\)\;/).captures
      symbols = JSON.parse(result_set[0])
      symbols['ResultSet']['Result'].each do |stock_symbol|
        next unless stock_symbol['symbol'].match(/^\w+$/) && stock_symbol['type'] == 'S'

        sq = StockQuote::Stock.quote(stock_symbol['symbol'])
        message += sq ? "#{stock_symbol['name']} : #{sq.latest_price} USD\n" : ''
      end
    elsif search =~ /energon/i
      message = 'ENERGON : ' + rand(300).to_s + " USD\n"
    end
    if message.empty?
      "Sin información para [#{search}]"
    else
      "Precios de accion para #{search}:\n#{message}"
    end
  end
end
