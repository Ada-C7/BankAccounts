require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 3: SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(12345, 9)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      # skip
      account = Bank::SavingsAccount.new(12345, 100)
      account.withdraw(25).must_equal 73
    end

    it "Outputs a warning if the balance would go below $10" do
      account = Bank::SavingsAccount.new(12345, 100)
      proc {
        account.withdraw(95)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      # skip
      account = Bank::SavingsAccount.new(12345, 100)
      account.withdraw(95)
      account.balance.must_equal 100
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      account = Bank::SavingsAccount.new(12345, 100)
      account.withdraw(89)
      account.balance.must_equal 100
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      account = Bank::SavingsAccount.new(12345, 100)
      account.add_interest(0.25).must_equal 0.25
    end

    it "Updates the balance with calculated interest" do
      account = Bank::SavingsAccount.new(12345, 100)
      account.add_interest(0.5)
      account.balance.must_equal 100.5

    end

    it "Requires a positive rate" do
      account = Bank::SavingsAccount.new(12345, 100)
      proc {
        account.add_interest(-0.5)
      }.must_raise ArgumentError
    end
  end
end
