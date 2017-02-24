require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '/Users/sai/Documents/ada/projects/BankAccounts/lib/account.rb'
require_relative '/Users/sai/Documents/ada/projects/BankAccounts/lib/savings_account.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
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
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      #raises an error if initial balance is less than 10
      proc {
        Bank::SavingsAccount.new(1337, 5, "1999-03-27 11:30:09 -0800" )
      }.must_raise ArgumentError
    end

    it "Initial balance over $10 is okay" do
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.balance.must_equal 100.0

    end

  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      # TODO: Your test code here!
    end

    it "Outputs a warning if the balance would go below $10" do
      # TODO: Your test code here!
    end

    it "Doesn't modify the balance if it would go below $10" do
      # TODO: Your test code here!
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      # TODO: Your test code here!
    end
  end

  describe "#add_interest" do
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
