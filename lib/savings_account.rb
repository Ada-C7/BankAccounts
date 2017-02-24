require 'csv'
require_relative '../lib/account'

module Bank

  class SavingsAccount < Account
    attr_reader :id, :balance

    def initialize(id, balance)

      raise ArgumentError.new "Balance must be at least $10" unless balance >= 10
      @id = id
      @balance = balance
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


  end
end
