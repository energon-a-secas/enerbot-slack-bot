require 'json'
require 'net/http'
require 'uri'
require 'stock_quote'

module Stock
  def self.fetch(text)
    search = ''
    message = ''
    if match = text.match(/^enerbot valor acci[oó]n (.*?)$/i)
      search = match.captures[0]
    end
    if search && (!search.empty? && search !~ /energon/i)
      uri = "http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=#{search}&region=1&lang=en&callback=YAHOO.Finance.SymbolSuggest.ssCallback"
      resultSet = Net::HTTP.get(URI(uri)).match(/YAHOO.Finance.SymbolSuggest.ssCallback\((.*?)\)\;/).captures
      symbols = JSON.parse(resultSet[0])
      symbols['ResultSet']['Result'].each { |stockSymbol|
        if stockSymbol['symbol'].match(/^\w+$/) && stockSymbol['type'] == 'S'
          sq = StockQuote::Stock.quote(stockSymbol['symbol'])
          message += sq ? "#{stockSymbol['name']} : #{sq.latest_price} USD\n" : ''
        end
      }
    elsif search =~ /energon/i
      message = 'ENERGON : ' + rand(300).to_s + ' USD\n'
    end
    unless message.empty?
      "Precios de accion para #{search}:\n#{message}"
    else 
      "Sin información para [#{search}]"
    end 
  end
end
