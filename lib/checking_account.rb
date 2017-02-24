require 'csv'
require 'date'
require_relative 'account'


module Bank
  class CheckingAccount < Account

    def initialize(id, balance, open_date='2010-12-21 12:21:12 -0800')
      super(id, balance, open_date)
    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new("Withdrawal amount must be >= 0") if withdrawal_amount < 0
      if withdrawal_amount > (@balance - 1)
        puts "You don't have enough in your account to withdraw that amount!"
      else @balance -= (withdrawal_amount + 1)
      end
      return @balance
    end



  end
end
