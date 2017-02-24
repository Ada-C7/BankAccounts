require 'time'
require_relative 'account'

module Bank
  class CheckingAccount < Account
    def initialize(id, balance, opendate)
      super
      @withdraw_fee = 1.0
      @minimum_balance = 0
      @check_count = 0
      @overdraft = -10
    end

    def withdraw(amount)
      super
    end

    def withdraw_using_check(amount)
      unless amount > 0
        raise ArgumentError.new "Withdrawal has be a positive amount!"
      end

      @check_count += 1
      if @check_count > 3
        @check_fee = 2.0
      else
        @check_fee = 0
      end

      if @balance - (amount + @check_fee) < @overdraft
        puts "You cannot overdraft more than $10!"
      else
        @balance -= (amount + @check_fee)
      end
      return @balance
    end

    def reset_checks
      @check_count = 0
    end

  end
end
