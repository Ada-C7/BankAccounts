require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(1337, 9)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      fee = 2.0
      account = Bank::SavingsAccount.new(1212, start_balance)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount - fee
      account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 99.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 92.0
      account = Bank::SavingsAccount.new(1920, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal start_balance
      # account.balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 100.0
      withdrawal_amount = 89.0
      account = Bank::SavingsAccount.new(1920, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal start_balance
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      start_balance = 983879.0
      rate = 0.025

      account = Bank::SavingsAccount.new(1920, start_balance)
      updated_balance = account.add_interest(rate)

      interest = updated_balance - start_balance
      interest.must_be_within_epsilon (start_balance*rate)
    end

    it "Updates the balance with calculated interest" do
      start_balance = 200
      rate = 0.011
      account = Bank::SavingsAccount.new(1676, start_balance)

      updated_balance = start_balance + (start_balance * rate)
      account.add_interest(rate).must_equal updated_balance
    end

    it "Requires a positive rate" do
      proc {
        Bank::SavingsAccount.new(1878, 100).add_interest(-10)
      }.must_raise ArgumentError
    end
  end
end
