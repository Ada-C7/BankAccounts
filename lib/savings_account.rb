require 'csv'
require 'date'
require_relative 'account'


module Bank
  class SavingsAccount < Account

    def initialize(id, balance, open_date='2010-12-21 12:21:12 -0800')
      super(id, balance, open_date)
      raise ArgumentError.new("balance must be >= 10") if balance < 10
    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new("Withdrawal amount must be >= 0") if withdrawal_amount < 0
      if withdrawal_amount > (@balance - 12)
        puts "You don't have enough in your account to withdraw that amount!"
      else @balance -= (withdrawal_amount + 2)
      end
      return @balance
    end

    def add_interest(rate)
      raise ArgumentError.new("Interest rate must be > 0") if rate <= 0
      interest = @balance * (rate/100)
      @balance += interest
      return interest
    end
  end
end
