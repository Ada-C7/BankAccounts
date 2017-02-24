require 'csv'
require_relative '../lib/account'

module Bank

  class CheckingAccount < Bank::Account

      attr_reader :balance, :id, :open_date, :interest
      attr_accessor :checks

      def initialize(id, balance, open_date, checks)

        if balance >= 10
          @balance = balance
        else
          raise ArgumentError.new "Initial savings account deposit must be at least $10"
        end

        @id = id
        @open_date = open_date
        @checks = checks

      end

    def withdraw(withdrawl_amount)

      raise ArgumentError.new("withdrawl must be greater than 0") if withdrawl_amount < 0

      if @balance - (withdrawl_amount + 1) >= 10
        @balance = @balance - (withdrawl_amount + 1)
      else
        print "your balance will be less than $10"
        return @balance
      end
    end

    def withdraw_using_check(amount)

      raise ArgumentError.new("check withdraw must be greater than 0") if amount < 0

      if @checks > 0
        withdrawl = amount
      else
        puts "you've used all 3 free checks for the month, the next transaction will have a $2 transaction fee"
        withdrawl = amount + 2
      end

      if @balance - (withdrawl) >= (-10)
        @balance -= withdrawl
        return @balance
      else
        print "your balance will be less than -$10"
        return @balance
      end
      @checks -= 1 # this means even if it's a bad check, they still used one of them

    end


    def reset_checks
      return @checks = 3
    end


  end
end
