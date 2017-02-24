require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
require_relative '../lib/MoneyMarketAccount'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "MoneyMarketAccount" do
  describe "#initialize" do
    before do
    end

    it "Is a kind of Account" do
      account = Bank::MoneyMarketAccount.new(1,10000)
      account.must_be_kind_of Bank::Account
    end

    it "Raises error if initial balance < 10,000" do
      # account = Bank::MoneyMarketAccount.new(1,9999)
      proc {Bank::MoneyMarketAccount.new(1,9999)}.must_raise ArgumentError
    end

    # it "maximum of 6 transactions per month - output message and do not perform transaction unless it's rectifying an overdrawn account" do
    # end

  end

  describe "#withdraw updates" do

    it "if withdrawal transaction brings balance to below 10000, impose $100 fee" do
      account = Bank::MoneyMarketAccount.new(1,10000)
      account.withdraw(1)
      account.balance.must_equal 9899
      account.too_low.must_be :==, true
    end

    it "if too_low is true, return message and don't allow transaction" do
      skip
      account = Bank::MoneyMarketAccount.new(1,9999)
      account.balance.must_equal 9999
      account.too_low.must_be :==, true
      proc {account.withdraw(1)}.must_output(/.+/)

      a
    end

    it "if balance < 10000, no more transactions allowed until balance is increased to >= 10000 using a deposit transaction" do
    end

    it "cannot withdraw if balance < 10000" do
    end

    it "if transactions >= 6 cannot withdraw" do
    end

    it "a withdrawal increases the number of transactions" do
    end
  end

  describe "#deposit updates" do
    it "if balance is below 10000, cannot deposit unless amount_deposited + balance >= 10000" do
    end

    it "no more transactions allowed until balance is increased using a deposit transaction" do
    end

    it "cannot withdraw if balance < 10000" do
    end

    it "if transactions >= 6 cannot deposit" do
    end

    it "unless the account is below 10000 and it is a deposit that brings the account back to 10000, a deposit counts toward transactions" do
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
    end

    it "Updates the balance with calculated interest" do
    end

    it "Requires a positive rate" do
    end
  end

  describe "#reset_transactions" do
    it "resets transactions to zero" do
    end

    it "can be called with no error" do
    end

  end
end
