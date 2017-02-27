require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

describe "SavingsAccount" do
  describe "#initialize" do
    # Check that a SavingsAccount is in fact a kind of account
    it "Is a kind of Account" do
      Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").must_be_kind_of Bank::Account
    end

    # Check that the initial balance is at least $10.00
    it "Requires an initial balance of at least $10, raises error otherwise" do
      proc {
        Bank::SavingsAccount.new(12345, 100, "1999-03-27 11:30:09 -0800")
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    # Decreases balance in decreased by the withdrawal amount, including $2 fee
    it "Applies a $2 fee each time" do
      Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(100).must_equal 9700
    end

    # Outputs a message warning the user
    it "Outputs a warning if the balance would go below $10" do
      proc {
        Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(9500)
      }.must_output (/.+/)
    end

    # Withdrawal amonut causes balance to go below $10
    it "Doesn't modify the balance if it would go below $10" do
      Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(9100).must_equal 10000
    end

    # Withdrawal amonut and the fee causes balance to go below $10
    it "Doesn't modify the balance if the fee would put it below $10" do
      Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(9000).must_equal 10000
    end
  end

  describe "#add_interest" do
    # Returns the actual interest amount
    it "Returns the interest calculated" do
      Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").add_interest(0.25).must_equal 2500
    end

    # Checks that the balance is updated
    it "Updates the balance with calculated interest" do
      account = Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.add_interest(0.25)
      account.balance.must_equal 12500
    end

    # Checks that the rate passed is valid data type
    it "Requires a positive rate" do
      proc {
        Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").add_interest(-0.32)
      }.must_raise ArgumentError
    end
  end
end
