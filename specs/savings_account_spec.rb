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
      # skip
      # TODO: Your test code here!
      proc {
        Bank::SavingsAccount.new(7)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      # skip
      # TODO: Your test code here!
      account = Bank::SavingsAccount.new(1337, 100.0)
      updated_balance = account.withdraw(25.0)

      updated_balance.must_equal 73.0

    end

    it "Outputs a warning if the balance would go below $10" do
      # skip
      # TODO: Your test code here!
      start_balance = 100.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      proc {account.withdraw(93.0)}.must_output(/.+/)

    end

    it "Doesn't modify the balance if it would go below $10" do
      # TODO: Your test code here!
      start_balance = 100.0
      withdrawal_amount = 93.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      # TODO: Your test code here!
      start_balance = 100.0
      withdrawal_amount = 93.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      # TODO: Your test code here!
      start_balance = 10000
      rate = 0.25
      account = Bank::SavingsAccount.new(1337, start_balance)

      interest = account.add_interest(rate)

      interest.must_equal (start_balance * rate / 100)
    end

    it "Updates the balance with calculated interest" do
      # TODO: Your test code here!
      start_balance = 10000
      rate = 0.25
      account = Bank::SavingsAccount.new(1337, start_balance)

      interest = account.add_interest(rate)

      account.balance.must_equal (interest + start_balance)

    end

    it "Requires a positive rate" do
      # TODO: Your test code here!
      proc {
        Bank::SavingsAccount.new(-1)
      }.must_raise ArgumentError

    end
  end
end
