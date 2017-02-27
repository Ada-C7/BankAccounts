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
      proc{ account = Bank::SavingsAccount.new(1212, 9)
      }.must_raise(ArgumentError)
    end
  end
  
  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      savings_account = Bank::SavingsAccount.new(11, 200)
      new_balance = savings_account.withdraw(10)
      new_balance.must_equal 188
    end

    it "Outputs a warning if the balance would go below $10" do
      savings_account = Bank::SavingsAccount.new(11, 200)
      savings_account.balance.must_equal 200
      savings_account.withdraw(191)
      proc { savings_account.withdraw(191)}.must_output(/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      savings_account = Bank::SavingsAccount.new(1212, 200)
      # savings_account.balance.must_equal 200
      savings_account.withdraw(191)
      savings_account.balance.must_equal 200
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      savings_account = Bank::SavingsAccount.new(1212, 200)
      savings_account.withdraw(189)
      savings_account.balance.must_equal 200
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      savings_account = Bank::SavingsAccount.new(11, 10000)
      interest = savings_account.add_interest(0.25)
      interest.must_equal 25.0
    end

    it "Updates the balance with calculated interest" do
      savings_account = Bank::SavingsAccount.new(11, 10000)
      savings_account.add_interest(0.25)
      savings_account.balance.must_equal 10025.0
    end

    it "Requires a positive rate" do
      savings_account = Bank::SavingsAccount.new(11, 10000)
      proc{ savings_account.add_interest(-1)
      }.must_raise(ArgumentError)
    end
  end
end
