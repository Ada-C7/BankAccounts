require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

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
      # skip
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      # skip
    proc {
          account = Bank::SavingsAccount.new(12345, 7.0)
         }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      account = Bank::SavingsAccount.new(12345, 5000.00)
      account.withdraw(500).must_equal 4498.0
    end

    it "Outputs a warning if the balance would go below $10" do
      # skip
      account = Bank::SavingsAccount.new(12345, 5000.00)
      proc {
        account.withdraw(4995)
      }.must_output (/.+/)

    end

    it "Doesn't modify the balance if it would go below $10" do
      # skip
      account = Bank::SavingsAccount.new(12345, 5000.00)
      account.withdraw(4995).must_equal 5000.00
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      # skip
      account = Bank::SavingsAccount.new(12345, 5000.00)
      account.withdraw(4990).must_equal 5000.00
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      skip
      # TODO: Your test code here!
    end

    it "Updates the balance with calculated interest" do
      skip
      # TODO: Your test code here!
    end

    it "Requires a positive rate" do
      skip
      # TODO: Your test code here!
    end
  end
end
