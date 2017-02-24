require 'CSV'
require_relative 'account.rb'

# Create a MoneyMarketAccount class which should inherit behavior from the Account class.
module Bank

  class MoneyMarketAccount < Account

    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new "Initial balance minimum is $10,000" if balance < 10000
      super(id, balance, open_date = nil)
    end

  end

end


# A maximum of 6 transactions (deposits or withdrawals) are allowed per month on this account type
# The initial balance cannot be less than $10,000 - this will raise an ArgumentError

# Updated withdrawal logic:
# If a withdrawal causes the balance to go below $10,000, a fee of $100 is
# imposed and no more transactions are allowed until the balance is increased using a
# deposit transaction.

# Each transaction will be counted against the maximum number of transactions

# Updated deposit logic: Each transaction will be counted against the maximum
# number of transactions. Exception to the above: A deposit performed to reach
# or exceed the minimum balance of $10,000 is not counted as part of the 6 transactions.
# #add_interest(rate): Calculate the interest on the balance and add the interest
# to the balance. Return the interest that was calculated and added to the balance
# (not the updated balance). Note** This is the same as the SavingsAccount interest.
# #reset_transactions: Resets the number of transactions to zero
