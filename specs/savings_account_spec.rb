require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
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
      Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10, raises error otherwise" do
      proc {
        Bank::SavingsAccount.new(12345, 100, "1999-03-27 11:30:09 -0800")
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      # TODO: Your test code here!
      Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(100).must_equal 9700
    end

    it "Outputs a warning if the balance would go below $10" do
      # TODO: Your test code here!
      proc {
        Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(9500)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      # TODO: Your test code here!
      Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(9100).must_equal 10000
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      # TODO: Your test code here!
        Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(9000).must_equal 10000
    end
  end

  xdescribe "#add_interest" do
    it "Returns the interest calculated" do
      # TODO: Your test code here!
    end

    it "Updates the balance with calculated interest" do
      # TODO: Your test code here!
    end

    it "Requires a positive rate" do
      # TODO: Your test code here!
    end
  end
end
