require_relative '../lib/account'
require 'csv'
require 'date'
module Bank
  class MoneyMarket < Account
    attr_reader :maximum_transactions
    def initialize(id, balance)
      raise ArgumentError.new("balance must be greater than 10.000$") if balance < 10000
      super(id, balance)
      @maximum_transactions = 6
    end

    def withdraw(amount)
      if @maximum_transactions <= 0
        puts "You can't have more than 6 transactions this month"
        return @balance
      end
      if @balance < 10000
        puts "You cannot withdraw, if your balance less than 10000$"
      else
        super(amount)
        if @balance < 10000
           @balance -= 100 # apply 100$ fee
           puts "Now your balance is #{@balance} (we charged 100$ fee)"
        end
        @maximum_transactions -= 1
      end
      return @balance
    end

    def deposit(amount)
      # A deposit performed to reach or exceed the minimum balance
      # of $10,000 is not counted as part of the 6 transactions.
      if @balance > 10000
        @maximum_transactions -= 1
      end
      super(amount)
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

    def reset_transactions
      @maximum_transactions = 0
    end


  end # end of class MoneyMarket
end # end of Bank module

acc = Bank::MoneyMarket.new(1, 20000)

acc.withdraw(500)
acc.withdraw(25000)
