require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
require_relative '../lib/SavingsAccount'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  describe "#initialize" do
    before do
      @savings = Bank::SavingsAccount.new(1,10)
    end

    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      @savings.initial_balance.to_i.must_be :>, 9
    end

    it "Raises error if initial balance < 10" do
      proc {Bank::SavingsAccount.new(1,9)}.must_raise ArgumentError
    end

  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      initial_deposit = 15
      withdrawal_amount = 1
      account = Bank::SavingsAccount.new(1,initial_deposit)
      initial_balance = account.balance
      account.withdraw(withdrawal_amount)
      final_balance = account.balance
      (initial_balance - final_balance).must_equal withdrawal_amount + 2
    end

    it "Outputs a warning if the balance would go below $10" do
      initial_deposit = 15
      account = Bank::SavingsAccount.new(1,initial_deposit)

      proc {account.withdraw(6)}.must_output(/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      initial_deposit = 10
      withdrawal_amount = 1
      account = Bank::SavingsAccount.new(1,initial_deposit)
      initial_balance = account.balance
      account.withdraw(withdrawal_amount)
      final_balance = account.balance
      (initial_balance - final_balance).must_equal 0
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      initial_deposit = 15
      withdrawal_amount = 5
      account = Bank::SavingsAccount.new(1,initial_deposit)
      initial_balance = account.balance
      account.withdraw(withdrawal_amount)
      final_balance = account.balance
      (initial_balance - final_balance).must_equal 0
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      account = Bank::SavingsAccount.new(1,100)
      account.balance.must_equal 100
      account.add_interest(0.25).must_equal 0.25
    end

    it "Updates the balance with calculated interest" do
      account = Bank::SavingsAccount.new(1,100)
      first_balance = account.balance
      interest_earned = account.add_interest(0.25)
      second_balance = account.balance
      second_balance.must_equal (first_balance + interest_earned)
    end

    it "Requires a positive rate" do
      account = Bank::SavingsAccount.new(1,100)
      test_rate = -0.25
      proc {account.add_interest(test_rate)}.must_output(/.+/)
    end
  end
end
