require_relative '../lib/account'
require 'csv'
require 'date'
module Bank
  class SavingsAccount < Account

    def initialize(id, balance)
      super(id, balance)
      raise ArgumentError.new("balance must be >= 10$") if balance < 10
    end

    # Inherits functionality from super class
    def withdraw(amount)
      fee = 2
      minimum_balance = 10
      super(amount, fee, minimum_balance)
    end

    def add_interest(rate)
      # Rate must be only between 0 and 1
      if rate < 0 || rate > 1
        raise ArgumentError.new("Rate should be between 0 and 1")
      end
      amount =  @balance * rate/100
      @balance += amount
      return amount
    end

  end # end of class SavingsAccount
end # end of Bank module

acc = Bank::SavingsAccount.new(1, 100)
acc.withdraw(150)
