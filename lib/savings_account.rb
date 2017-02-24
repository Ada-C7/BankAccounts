require 'csv'
require_relative 'account'
# SavingsAccount class to inherit behavior from the Account class

module Bank
  class SavingsAccount < Bank::Account
    attr_reader :balance

    def initialize(id, initial_balance)

      raise ArgumentError.new("Initial balance must be >= $10") if initial_balance < 10

      @balance = initial_balance


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
