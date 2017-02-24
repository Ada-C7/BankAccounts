require 'time'
require_relative 'account'

module Bank
  class SavingsAccount < Account
    def initialize(id, balance, opendate)
      unless balance >= 10
        raise ArgumentError.new "Need at least $10."
      end
      super
      @withdraw_fee = 2.0
      @minimum_balance = 10.0
    end

    def withdraw(amount)
      super
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
