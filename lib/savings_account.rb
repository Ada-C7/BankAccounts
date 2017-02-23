require 'csv'
require_relative '../lib/account'
module Bank
  class SavingsAccount < Bank::Account
    attr_reader :balance, :id, :open_date


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
      fee = 2

      if @balance - withdrawl_amount - fee >= 10
        @balance -= (withdrawl_amount + fee)
      else
        print "your balance will be less than $10"
        return @balance += (@balance * rate/100)
      end
    end


    def add_interest(rate)
      rate = 0.25
      @balance += @balance
    end
  end
end
