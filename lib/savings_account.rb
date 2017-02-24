require_relative 'account'

module Bank
  class SavingsAccount < Account

    def initialize(id, balance, timedate = nil, min_bal = 10)
      super
    end

    def withdraw(withdrawal_amount)
      super
      if @balance < withdrawal_amount - 10
        puts "Warning low balance!"
        @balance
      else
        @balance -= 2
      end
    end

  end#class SavingsAccount
end#module Bank
