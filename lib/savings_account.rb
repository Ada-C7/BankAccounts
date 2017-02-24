require 'csv'
require_relative '../lib/account'

module Bank

  class SavingsAccount < Bank::Account
    attr_reader :balance, :id, :open_date, :interest, :min_balance

    def initialize(id, balance, open_date)
      @min_balance = 10

      if balance >= @min_balance
        @balance = balance
      else
        raise ArgumentError.new "Initial savings account deposit must be at least $10"
      end

      @id = id
      @open_date = open_date


    end

    def withdraw(withdrawl_amount)
      fee = 2
      raise ArgumentError.new("withdrawl must be greater than 0") if withdrawl_amount < 0

      if @balance - (withdrawl_amount + fee) >= @min_balance #put @balance in attribute accessor and get rid of the @ sign?
        super(withdrawl_amount)
        return @balance - fee
      else
        puts "insufficient funds"
        return @balance

        #
        #   @balance = @balance - (withdrawl_amount + 2)
        # else
        #   print "your balance will be less than $10"
        #   return @balance
        #
        # end

      end

    end

    def add_interest(rate)

      if rate > 0

        @interest = @balance * (rate/100)
        @balance = @balance + @interest
        return @interest.round(2)

      else

        raise ArgumentError.new ("rate must be positive")

      end
    end
  end
end
