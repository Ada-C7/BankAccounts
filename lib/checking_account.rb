require_relative './account'
require 'csv'

module Bank
  class MoneyMarketAccount < Bank::Account
    def initialize(id, balance)
      super(id, balance)
    end

    def withdraw(amount)
      amount += 1

      if (@balance - amount) < 0
        return @balance
        raise ArgumentError.new("account must be > 0") if (@balance - amount) < 0
      else
        @balance = @balance - amount
        return @balance
      end
    end

  end
end
