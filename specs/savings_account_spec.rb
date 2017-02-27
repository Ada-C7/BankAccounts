require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

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
      # skip
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(666, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      # skip
      proc {
        Bank::SavingsAccount.new(666, 1)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      # skip
      start_balance = 100.0
      withdraw_amount = 50.0
      account = Bank::SavingsAccount.new(666, start_balance)

      account.withdraw(withdraw_amount)

      expected_balance = start_balance - withdraw_amount - 2
      account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the balance would go below $10" do
      # skip
      proc {
        Bank::SavingsAccount.new(666, 1)
      }.must_raise ArgumentError
    end

    it "Doesn't modify the balance if it would go below $10" do
      # skip
      start_balance = 20
      withdraw_amount = 21
      account = Bank::SavingsAccount.new(666, start_balance)

      account.withdraw(withdraw_amount)

      account.balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      skip
      start_balance = 11
      withdraw_amount = 2
      account = Bank::SavingsAccount.new(666, start_balance)

      account.withdraw(withdraw_amount)

      account.balance.must_equal start_balance
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      # skip
      start_balance = 100.0
      withdraw_amount = 25.0
      interest_rate = 0.25
      account = Bank::SavingsAccount.new(666, start_balance)

      account.add_interest(interest_rate)

      expected_interest = start_balance + (interest_rate / 100.0)
      account.interest.must_equal expected_interest
    end

    it "Updates the balance with calculated interest" do
      # skip
      start_balance = 100
      withdraw_amount = 25.0
      interest_rate = 0.25
      account = Bank::SavingsAccount.new(666, start_balance)

      account.add_interest(interest_rate)

      expected_balance = start_balance + (start_balance * (interest_rate / 100.0))
      account.balance.must_equal expected_balance
    end

    #This test wasn't mentioned in the requirements so I wasn't
    #sure what y'all were looking for.
    it "Requires a positive interest rate" do
      # skip
      start_balance = 100
      withdraw_amount = 25.0
      interest_rate = -0.25
      account = Bank::SavingsAccount.new(666, start_balance)

      proc {
        account.add_interest(interest_rate)
      }.must_raise ArgumentError

    end
  end
end
