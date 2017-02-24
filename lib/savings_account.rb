require 'time'
require_relative 'account'

module Bank
  class SavingsAccount < Account
    def initialize(id, balance, opendate)
      unless balance >= 10
        raise ArgumentError.new "Need at least $10."
      end
      super(id, balance, opendate)
    end

    def withdraw(amount)
      fee = 2.0
      unless amount > 0
        raise ArgumentError.new "Withdrawal has be a positive amount!"
      end

      if @balance - (amount + fee) < 10.0
        puts "Can't withdraw more than you have!"
        return @balance
      else
        @balance -= (amount + fee)
        return @balance
      end
    end

    def add_interest(rate)
      unless rate > 0
        raise ArgumentError.new "Rate must be positive!"
      end
      interest_gained = @balance * rate/100
      @balance + interest_gained
      return interest_gained
    end
  end
end
