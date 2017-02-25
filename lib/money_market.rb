require_relative 'account'

module Bank

  class MoneyMarketAccount < Account
    attr_accessor :transactions

    #Initializes with at least $10,000 and a transaction limit of 6
    def initialize(id, balance)
      raise ArgumentError.new "Money Market Accounts must
      have at least $10,000" if balance < 10000
      super(id, balance)
      @transactions = 6
    end

    #Does not allow more than six transactions or for the account to go under 10,000
    def withdraw(amount)
      raise ArgumentError.new "You have run out of transactions" if @transactions == 0
      if balance < 10000
        puts "You cannot make any more transactions until you are over $10,000"
      elsif balance - amount < 10000
        amount += 100
        @balance -= amount
        @transactions -= 1
      else
        @balance -= amount
        @transactions -= 1
      end
    end

    #only counts transactions if it's not bringing the balance back to $10,000
    def deposit(amount)
      if (balance < 10000) && (balance + amount >= 10000)
        @balance += amount
      else
        @balance += amount
        @transactions -= 1
      end
    end

    #Calculates interest rate, returns interest accrued
    def interest(rate)
      raise ArgumentError.new "The rate must be a positive number" if rate < 0
      interest = @balance * rate/100
      @balance += interest
      return interest
    end

    #Resets transactions
    def reset_transactions
      @transactions = 6
    end

  end

end
