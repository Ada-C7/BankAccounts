require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require 'savings_account'
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
      account = SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      initial_balance = 1
      proc { Bank::Account.new(1337, initial_balance) }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do

    it "Has a withdraw method" do
      account = SavingsAccount.new(12345, 100.0)
      account.must_respond_to :withdraw
    end

    it "Applies a $2 fee each time" do
      fee = 2.0
      initial_balance = 100.0
      account = SavingsAccount.new(12345, initial_balance)
      withdrawal_amount = 50.0
      new_balance = account.withdraw(withdrawal_amount)
      new_balance.must_equal (initial_balance - withdrawal_amount - fee)
    end

    it "Outputs a warning if the balance would go below $10" do
      account = SavingsAccount.new(12345, 100.0)
      withdrawal_amount = 200.0
      proc {account.withdraw(withdrawal_amount)}.must_output "Insufficient funds, balance would go below $10.\n"
    end

    it "Doesn't modify the balance if it would go below $10" do
      initial_balance = 100.0
      account = SavingsAccount.new(12345, initial_balance)
      withdrawal_amount = 200.0
      new_balance = account.withdraw(withdrawal_amount)
      new_balance.must_equal initial_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      initial_balance = 20.0
      account = SavingsAccount.new(12345, initial_balance)
      withdrawal_amount = 10.0
      new_balance = account.withdraw(withdrawal_amount)
      new_balance.must_equal initial_balance
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
