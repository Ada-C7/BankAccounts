require 'CSV'
require_relative 'account.rb'

# Create a MoneyMarketAccount class which should inherit behavior from the Account class.
module Bank

  class MoneyMarketAccount < Account
  attr_accessor :used_transactions

    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new "Initial balance minimum is $10,000" if balance < 10000
      super(id, balance, open_date = nil)
      @used_transactions = 0
    end


    def withdraw(amount)
      raise Argument.Error.new "Your balance is below the $10,000 minumum. Make a deposit first."

      super(amount)

      if @balance < 10000
        @balance -= 100
      end

      track_transactions
    end


    def deposit(amount)
      super(amount)

      track_transactions
    end


    def add_interest(rate)
      raise ArgumentError.new "The interest rate must be a positive amount." if rate < 0
      @interest = @balance * (rate / 100)
      @balance += @interest
      return @interest
    end


    def track_transactions
      raise ArgumentError.new "You have exceeded the maximimum number of transactions." if @used_transactions >= 6
      @used_transactions += 1
    end


    def reset_transactions
      @used_transactions = 0
    end

  end
end


# A maximum of 6 transactions (deposits or withdrawals) are allowed per month on this account type
# The initial balance cannot be less than $10,000 - this will raise an ArgumentError


# Updated deposit logic: Each transaction will be counted against the maximum
# number of transactions. Exception to the above: A deposit performed to reach
# or exceed the minimum balance of $10,000 is not counted as part of the 6 transactions.
# #reset_transactions: Resets the number of transactions to zero
