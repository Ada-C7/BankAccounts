require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savingsaccount'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
# require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(id: 12345, balance: 10000)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(id: 12345, balance: 900)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    before do
      @account = Bank::SavingsAccount.new(id: 12345, balance: 10000)
    end

    it "Applies a $2 fee each time" do
      @account.withdraw(1000)
      @account.balance.must_equal 8800
    end

    it "Outputs a warning & doesn't modify the balance if it would go below $10" do
      proc {
        @account.withdraw(9000)
      }.must_output(/.+/)

      @account.balance.must_equal 10000
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      proc {
        @account.withdraw(9000)
      }.must_output(/.+/)

      @account.balance.must_equal 10000
    end
  end

  describe "#add_interest" do
    before do
      @account = Bank::SavingsAccount.new(id: 12345, balance: 1000000)
    end

    it "Returns the interest calculated" do
      @account.add_interest(0.25).must_equal 2500
    end

    it "Updates the balance with calculated interest" do
      @account.add_interest(0.25)
      @account.balance.must_equal 1002500
    end

    it "Requires a positive rate" do
      proc {
        @account.add_interest(-0.25)
      }.must_raise ArgumentError
    end
  end
end
