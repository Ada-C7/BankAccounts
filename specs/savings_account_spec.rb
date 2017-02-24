require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'
require_relative '../lib/account'
require 'csv'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb


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
      account = Bank::SavingsAccount.new(1234, 100)
      account.balance.must_be :>=, 10
    end

    it "Error if initial balance < 10" do
      proc {
        Bank::SavingsAccount.new(100, 5)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      account = Bank::SavingsAccount.new(1234, 100)
      amount_to_withdraw = 10
      expected_result = account.balance - amount_to_withdraw - 2
      account.withdraw(amount_to_withdraw).must_equal expected_result
    end

    it "Outputs a warning if the balance would go below $10" do
        account = Bank::SavingsAccount.new(1234, 100)
        amount_to_withdraw = 90
        proc {
          account.withdraw(amount_to_withdraw)
        }.must_output /.+/
    end

    it "Doesn't modify the balance if it would go below $10" do
      balance = 100
      amount_to_withdraw = 95
      account = Bank::SavingsAccount.new(1234, balance)
      account.withdraw(amount_to_withdraw).must_equal 100
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      balance = 100
      amount_to_withdraw = 89
      account = Bank::SavingsAccount.new(1234, balance)
      puts account.withdraw(amount_to_withdraw)
      account.withdraw(amount_to_withdraw).must_equal balance
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      account = Bank::SavingsAccount.new(1234, 10000)
      rate = 0.25
      expected_interest = account.balance * rate/100
      account.add_interest(rate).must_equal expected_interest
    end

    it "Updates the balance with calculated interest" do
      account = Bank::SavingsAccount.new(1234, 10000)
      current_balance = account.balance
      rate = 0.25
      interest_amount = account.add_interest(rate)
      (current_balance + interest_amount).must_equal account.balance
    end

    it "Requires a positive rate" do
      account = Bank::SavingsAccount.new(1234, 10000)
      rate = -2
      proc {
        account.add_interest(rate)
      }.must_raise ArgumentError
    end
  end
end
