require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/savings_account.rb'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {Bank::SavingsAccount.new(1337, 9.0)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::SavingsAccount.new(1991, start_balance)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount - 2
      account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 96.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      account.withdraw(withdrawal_amount)
      account.balance.must_equal start_balance, "Outputs a warning if the balance would go below $10"
    end

    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 200.0
      withdrawal_amount = 300.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      account.withdraw(withdrawal_amount)
      account.balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 100.0
      withdrawal_amount = 95.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      account.withdraw(withdrawal_amount)

      account.balance.must_equal start_balance
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      interest_rate = 0.25
      start_balance = 10000.0
      account = Bank::SavingsAccount.new(1337, start_balance)
      interest_account = account.interest(interest_rate)
      interest_account.must_equal start_balance * (interest_rate/100), "Calculated interest was not returned."

    end

    it "Updates the balance with calculated interest" do skip
      interest_rate_rate = 0.25
      start_balance = 10000.0
      account = Bank::SavingsAccount.new(1337, start_balance)
      interest_account = account.interest(interest_rate)
      interest_account.must_equal (start_balance + (start_balance * (interest_rate/100)))
    end

    it "Requires a positive rate" do
      account = Bank::SavingsAccount.new(1337, 100.0)

      proc {
        account.interest(-0.25)
      }.must_raise ArgumentError
    end
  end
end
