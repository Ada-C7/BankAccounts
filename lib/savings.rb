require 'csv'
require 'pry'
require_relative 'account.rb'


module Bank
  class SavingsAccount < Account

    def initialize(account)

      raise ArgumentError.new "Savings Accounts must have an Initial Balance of $10" if account[:balance] < 10
      super

    end

    def withdraw(amount)

      if (@balance - (amount + 2) ) < 10
        puts "Insufficient Funds"
        return @balance
      end
      super
      return @balance - 2

    end


    def add_interest(rate)

      if rate < 0
        print "We do not accept negative rates"
        return @balance
      else
        interest = @balance * (rate/100)
        @balance += interest
        return interest
      end

    end


  end
end

new_account = Bank::SavingsAccount.new({balance: 10})
puts new_account.balance
