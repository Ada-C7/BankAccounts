# Question for teacher or tutor... Am I actually inheriting anything from Account??

require 'csv'
require_relative 'account'
# SavingsAccount class to inherit behavior from the Account class

module Bank
  class SavingsAccount < Account
    attr_reader :balance

    def initialize(id, balance, datetime=nil)

      if balance > 10
        @balance = balance
      else
        raise ArgumentError.new("Initial balance must be >= $10")
      end
      # Calling super will now allow SavingsAccount to use info from Account
      # if the balance is not less than 10
      super

    end

    def withdraw(withdrawal_amount)
      fee = 2.0
      total_withdrawal = withdrawal_amount + fee

      if @balance - total_withdrawal < 10
        puts "Oh no! Your account will go under $10 with this transaction"
        return @balance
      else
        @balance -= total_withdrawal
      end
    end

    def add_interest(rate)

      if rate >= 0

        interest_amount = @balance * rate / 100

      else
        raise ArgumentError.new("rate  must be >= 0")
      end

      @balance += interest_amount

      return interest_amount

      #return @balance

    end
  end

end
