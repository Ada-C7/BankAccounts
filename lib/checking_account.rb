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

    #Note: In the video for Wave 3 it was mentioned that we could
    #forgo counting by month. I did not account for time.
    def withdraw_using_check(amount)
      counter = 0
      test_balance = @balance - amount
      raise ArgumentError.new("needs a positive withdrawal amount") if amount < 0

      if counter <= 3 && test_balance < -10
        return @balance
        raise ArgumentError.new("account will go below -10") if (@balance - amount) < -10
      elsif counter <= 3 && test_balance >= -10
        @balance = @balance - amount
        return @balance
        counter += 1
      elsif counter > 3 && test_balance >= -10
        @balance = @balance + 2
        counter += 1
      elsif counter > 3 && test_balance < -10
        raise ArgumentError.new("account will go below -10") if (@balance - amount) < -10
        return @balance
      end
    end

  end
end

# test_1 = Bank::MoneyMarketAccount.new(666, 100)
# puts test_1.withdraw_using_check(2)
