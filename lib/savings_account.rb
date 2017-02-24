require 'csv'
require_relative '../lib/account'
module Bank
  class SavingsAccount < Bank::Account
    attr_reader :balance, :id, :open_date, :interest


    def initialize(id, balance, open_date)

      if balance >= 10
        @balance = balance
      else
        raise ArgumentError.new "Initial savings account deposit must be at least $10"
      end

      @id = id
      @open_date = open_date
    end

    def withdraw(withdrawl_amount)
      raise ArgumentError.new("withdrawl must be greater than 0") if withdrawl_amount < 0
      if @balance - (withdrawl_amount + 2) >= 10
        @balance = @balance - (withdrawl_amount + 2)
      else
        print "your balance will be less than $10"
        return @balance

      end
    end

    def add_interest(rate)
      if rate > 0
        @interest = @balance * (rate/100)
        @balance = @balance + @interest
        return @interest.round(2)
      else raise ArgumentError.new ("rate must be positive")
      end
    end
  end
end
