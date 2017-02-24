require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/money_market_account.rb'

# Create a MoneyMarketAccount class which should inherit behavior from the Account class.
describe "MoneyMarketAccount" do

  describe "#initialize" do

    it "Is a kind of Account" do
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Raises an error if initial balance is less than $10,000" do
      proc {Bank::SavingsAccount.new(12345, 100)}.must_raise ArgumentError
    end

  end



# A maximum of 6 transactions (deposits or withdrawals) are allowed per month on this account type

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
