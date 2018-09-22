class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks
  attr_accessor :can_be_added

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
  
  def self.new_from_lookup(ticker_symbol)
    begin
      looked_up_stock = StockQuote::Stock.quote(ticker_symbol)

      price = looked_up_stock.close
      new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: price)
    rescue Exception => e
      return nil
    end
  end

  #Stock cannot be added because you already added
  #10 stocks
  #this stock

end
