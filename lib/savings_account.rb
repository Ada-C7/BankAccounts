require 'csv'
require_relative '../lib/account'

module Bank

  class SavingsAccount < Account
    attr_reader :id, :balance, :interest

    def initialize(id, balance)

      raise ArgumentError.new "Balance must be at least $10" unless balance >= 10
      @id = id
      @balance = balance
      @interest = interest
    end

    def withdraw(withdrawal_amount)
      temp_balance = @balance - (withdrawal_amount + 2)
      if temp_balance < 10
        puts "Warning, this will make your balance below your mininum , the current balance is " + (@balance.to_s)
        @balance
      else
        super + (-2)
      end
    end

    def add_interest(rate)
      if rate < 0
        raise ArgumentError.new "The interest rate cannot be negative"
      else
        interest = @balance * (rate / 100).to_f
        @balance += interest
        return interest
      end
    end

  end


end
