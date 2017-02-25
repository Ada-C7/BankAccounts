require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

describe "SavingsAccount" do

  describe "#initialize" do
    it "Is a kind of Account" do
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(12345, 9.0)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      fee = 2.0
      account = Bank::SavingsAccount.new(12345, start_balance)
      account.withdraw(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount - fee
      account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::SavingsAccount.new(12345, start_balance)
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 10.0
      withdrawal_amount = 11.0
      updated_balance = start_balance
      account = Bank::SavingsAccount.new(12345, start_balance)
      account.withdraw(withdrawal_amount)
      updated_balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 10.0
      withdrawal_amount = 20.0
      fee = 2.0
      account = Bank::SavingsAccount.new(12345, start_balance)
      updated_balance = account.withdraw(withdrawal_amount + fee)
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end
  end
  #
  describe "#add_interest" do
    it "Returns the interest calculated" do
      rate = 0.25
      start_balance = 100.0
      interest = start_balance * rate/100
      account = Bank::SavingsAccount.new(12345, start_balance)
      account.add_interest(rate).must_equal interest
    end

    it "Updates the balance with calculated interest" do
      start_balance = 200.0
      rate = 0.25
      interest = start_balance * rate/100
      account = Bank::SavingsAccount.new(12345, start_balance)
      account.add_interest(rate)
      updated_balance = start_balance + interest
      account.balance.must_equal updated_balance
    end

    it "Requires a positive rate" do
      start_balance = 200.0
      rate = 0.25
      account = Bank::SavingsAccount.new(12345, start_balance)
      account.add_interest(rate)
      proc {
        account.add_interest(-1)
      }.must_output (/.+/)
    end
  end
end
