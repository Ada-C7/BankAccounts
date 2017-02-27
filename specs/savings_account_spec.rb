require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      # skip
      proc {
      account = Bank::SavingsAccount.new(12345, 5.0)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      # skip
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.withdraw(5).must_equal 95 - 2

    end

    it "Outputs a warning if the balance would go below $10" do
      # skip

      proc {
        account = Bank::SavingsAccount.new(12345, 20.0)
        account.withdraw(15)
      }.must_raise ArgumentError
    end

    it "Doesn't modify the balance if it would go below $10" do
      # skip
      account = Bank::SavingsAccount.new(12345, 20.0)
      proc {
      account.withdraw(15)
      }.must_raise ArgumentError
      account.balance.must_equal 20
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      # skip
      account = Bank::SavingsAccount.new(12345, 20.0)
      proc {
        account.withdraw(9)
      }.must_raise ArgumentError
      account.balance.must_equal 20
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      # skip
      account = Bank::SavingsAccount.new(12345, 10000.0)
      account.add_interest(0.25).must_equal 25
    end

    it "Updates the balance with calculated interest" do
      # skip
      account = Bank::SavingsAccount.new(12345, 10000.0)
      account.add_interest(0.25)
      account.balance.must_equal 10025
    end

    it "Requires a positive rate" do
      # skip
      account = Bank::SavingsAccount.new(12345, 10000.0)
      proc {
        account.add_interest(-25)
      }.must_raise ArgumentError
    end
  end
end
