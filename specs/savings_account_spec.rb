require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0, "1999-03-27 11:30:09 -0800")
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      start_balance = 7.0

      proc {
        account = Bank::SavingsAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      hidden_fee = 2.0
      account = Bank::SavingsAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount - hidden_fee
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 95.0
      account = Bank::SavingsAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      proc {
        account.withdraw(withdrawal_amount)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 95.0
      account = Bank::SavingsAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 100.0
      withdrawal_amount = 89.0 # fee is 2 dollars more
      account = Bank::SavingsAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      balance = 1000.0
      interest_rate = 0.23
      expected_interest = 2.3
      account = Bank::SavingsAccount.new(1337, balance, "1999-03-27 11:30:09 -0800")

      account.add_interest(interest_rate).must_equal expected_interest
    end

    it "Updates the balance with calculated interest" do
      balance = 1000.0
      interest_rate = 0.25
      expected_value = 1002.5
      account = Bank::SavingsAccount.new(1337, balance, "1999-03-27 11:30:09 -0800")

      new_balance = balance + account.add_interest(interest_rate)
      new_balance.must_equal expected_value
    end

    it "Requires a positive rate" do
      interest_rate = -0.24
      account = Bank::SavingsAccount.new(1337, 100.0, "1999-03-27 11:30:09 -0800")

      proc {
        account.add_interest(interest_rate)
      }.must_raise ArgumentError
    end
  end
end
