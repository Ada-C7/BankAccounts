require 'csv'
require 'pry'
require_relative 'account.rb'


module Bank
  class SavingsAccount < Account

    attr_accessor :balance

    def initialize(account)

      @id = account[:id].to_i
      @balance = account[:balance].to_i
      @opendatetime = account[:opendatetime]

      if @balance >= 10
        @balance = @balance
      else
        raise ArgumentError.new "Savings Accounts must have an Initial Balance of $10"
      end

    end

    def withdraw(amount) #this one is weird - can figue out how to override the parent

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
