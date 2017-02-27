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
        Bank::SavingsAccount.new(12345, 9)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 100.0
      withdrawal_amount = 25.00
      fee = 2.0
      account = Bank::SavingsAccount.new(12345, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount - fee

      # Both the value returned and the balance in the account
      # should apply the fee
      updated_balance.must_equal expected_balance
      account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 91.0
      account = Bank::SavingsAccount.new(12345, start_balance)

      # Anything printed to the console output will pass the test
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 91.0
      account = Bank::SavingsAccount.new(12345, start_balance)

      updated_balance = account.withdraw(withdrawal_amount = 91.0)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 100.0
      withdrawal_amount = 90.0 # + 2.0 fee

      account = Bank::SavingsAccount.new(12345, start_balance)

      updated_balance = account.withdraw(withdrawal_amount = 91.0)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance

    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      account = Bank::SavingsAccount.new(12345, 10_000.0)
      rate = 0.25 # percentage
      interest = account.add_interest(rate)
      expected_interest = 25.0

      interest.must_equal expected_interest
    end

    it "Updates the balance with calculated interest" do
      rate = 0.25 # percentage
      account = Bank::SavingsAccount.new(12345, 10_000.0)
      account.add_interest(rate)

      expected_balance = 10_025.0
      account.balance.must_equal expected_balance
    end

    it "Requires a positive rate" do
      rate = -0.25
      account = Bank::SavingsAccount.new(12345, 10_000)

      proc {
        account.add_interest(rate)
      }.must_raise ArgumentError
    end
  end
end
