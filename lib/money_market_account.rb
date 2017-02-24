require 'csv'
require 'date'
require_relative 'account'


module Bank

  class MoneyMarketAccount < Account

    def initialize(id, balance, open_date='2010-12-21 12:21:12 -0800')
      super(id, balance, open_date)
      raise ArgumentError.new("balance must be >= 10,000") if balance < 10000
    end

  end
end
