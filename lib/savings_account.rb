require_relative 'account'
require 'csv'

module Bank

  class SavingsAccount < Account
    attr_accessor :calculated_interest

    def initialize(id, balance, open_date = nil)
      super(id, balance, open_date = nil)
      raise ArgumentError.new "The initial balance must not be less than 10" if balance < 10
      @calculated_interest = nil
    end

    def withdraw(money_to_withdraw)
      if @balance - (money_to_withdraw + 2) < 10
        puts "Warning! This withdrawal will put you under the $10 account minimum!"
        return @balance
      else
        super(money_to_withdraw)
          return @balance -= 2.0
      end
    end

    def add_interest(rate)
        raise ArgumentError.new("interest rate must be greater than 0") if rate < 0
        @calculated_interest = balance * rate / 100
        @balance += @calculated_interest
        return @calculated_interest

    end

    # def calculate_interest(rate)
    #   @calculated_interest = balance * rate / 100
    # end

  end
end


# Create a SavingsAccount class which should inherit behavior from the Account class. It should include the following updated functionality:
#
# The initial balance cannot be less than $10. If it is, this will raise an ArgumentError
# Updated withdrawal functionality:
# Each withdrawal 'transaction' incurs a fee of $2 that is taken out of the balance.
# Does not allow the account to go below the $10 minimum balance - Will output a warning message and return the original un-modified balance
