require 'csv'
require_relative 'account'

module Bank
  class MoneyMarketAccount < Bank::Account
    attr_accessor :new_month
    attr_reader :num_transaction
    def initialize(id, balance, open_date)
      raise ArgumentError.new("Your initial balance must be at least $10,000.00") if balance < 1000000
      super(id, balance, open_date)
      @num_transaction = 0
      @new_month = false
    end

  end
end
