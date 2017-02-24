require 'CSV'
require_relative 'account.rb'
require 'pry'

module Bank

  # Created SavingsAccount class that is a child of the Account class
  class SavingsAccount < Bank::Account

    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new "The minimum balance is $10.00." if balance < 10
      super(id, balance, open_date = nil)
    end

    def withdraw(amount)
      raise ArgumentError.new "The mimimum balance is $10.00." if @balance - 2 - amount < 10
      super(amount)
      @balance -= 2
    end

  end
end

# The initial balance cannot be less than $10. If it is, this will
# raise an ArgumentError. Updated withdrawal functionality:
# Each withdrawal 'transaction' incurs a fee of $2 that is taken out of the balance.
# Does not allow the account to go below the $10 minimum balance - Will output
# a warning message and return the original un-modified balance

# It should include the following new method:
# add_interest(rate): Calculate the interest on the balance and add the interest
# to the balance. Return the interest that was calculated and added to the balance
# (not the updated balance). Input rate is assumed to be a percentage (i.e. 0.25).
# The formula for calculating interest is balance * rate/100 Example: If the interest
# rate is 0.25 and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.
