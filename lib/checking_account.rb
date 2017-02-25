require 'csv'
require_relative 'account'

# CheckingAccount class to inherit behavior from the Account class
module Bank
  class CheckingAccount < Account
    attr_accessor :balance
    attr_reader :check_counter

    def initialize(id, balance)
      super(id, balance)
      @balance = balance
      # we want to use balance from Account and make sure it doesn't dip below -10
      @check_counter = 0
    end

    def withdraw(withdrawal_amount)

      super( withdrawal_amount + 1 )

    end

    def withdraw_using_check(amount)
      #how can I make my @check_counter a counter type kinda like what I see in loops

      raise ArgumentError.new("Withdraw amount must be >= 0") if amount < 0

      if balance - amount < -10.0
        puts "You're withdraw request must leave your balance >= -$10"
        return @balance
      else
        if @check_counter >= 3
          fee = 2
          @balance -= (amount + fee)
          @check_counter +=1
        else
          @balance -= amount
          @check_counter += 1
        end
      end


      return @balance

    end

    def reset_checks

      @check_counter = 0

    end

  end
end
