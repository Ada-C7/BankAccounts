require 'CSV'
require_relative 'account.rb'
require 'pry'

module Bank

  # Created SavingsAccount class that is a child of the Account class
  class SavingsAccount < Bank::Account
  attr_accessor :interest

    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new "The minimum balance is $10.00." if balance < 10
      super(id, balance, open_date = nil)
      @interest = 0
    end

    def withdraw(amount)
      raise ArgumentError.new "The mimimum balance is $10.00." if @balance - 2 - amount < 10
      super(amount)
      @balance -= 2
    end

    def add_interest(rate)
      raise ArgumentError.new "The interest rate must be a positive amount." if rate < 0
      @interest = @balance * (rate / 100)
      @balance += @interest
      return @interest
    end

  end
end

# It should include the following new method:
# add_interest(rate): Calculate the interest on the balance and add the interest
# to the balance. Return the interest that was calculated and added to the balance
# (not the updated balance). Input rate is assumed to be a percentage (i.e. 0.25).
# The formula for calculating interest is balance * rate/100 Example: If the interest
# rate is 0.25 and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.
