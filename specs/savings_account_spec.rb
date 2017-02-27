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
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(1213, 9)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      account.withdraw(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount - 2
      account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 89.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "The balance equals the start balance minus the withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = 50.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal 48
    end

    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 91.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 100.0
      withdrawal_amount = 89.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      start_balance = 10000
      rate_amount = 0.25
      account = Bank::SavingsAccount.new(1337, start_balance)

      interest_rate = account.add_interest(rate_amount)

      interest_rate.must_equal 25
    end

    it "Updates the balance with calculated interest" do
      start_balance = 10000
      rate_amount = 0.25
      account = Bank::SavingsAccount.new(1337, start_balance)

      interest_amount = account.add_interest(rate_amount)

      interest_amount.must_equal 25
      account.balance.must_equal 10025
    end

    it "Requires a positive rate" do
      start_balance = 10000
      rate_amount = -0.25
      account = Bank::SavingsAccount.new(1337, start_balance)

      proc {
        account.add_interest(rate_amount)
      }.must_raise ArgumentError
    end
    
  end
end
