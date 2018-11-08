module Stock
  def self.fetch(data)
    require 'stock_quote'
    "#{StockQuote::Stock.quote('ltm').latest_price} USD"
  end
end
