require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/money_market_account'

describe "MoneyMarketAccount" do
  before do
    @account = Bank::MoneyMarketAccount.new(12345, 2000000, "1999-03-27 11:30:09 -0800")
  end

  describe "#initialize" do
    it "Is a kind of Account" do

      # Check that a MoneyMarketAccount is in fact a kind of account
      @account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10,000" do
      proc {
        Bank::MoneyMarketAccount.new(12345, 999999, "1999-03-27 11:30:09 -0800")
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Outputs a warning if the account would go negative with the fee" do
      proc { @account.withdraw(1990001) }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the $100 fee makes the account go negative" do
      updated_balance = @account.withdraw(1990001)
      updated_balance.must_equal 2000000
      @account.balance.must_equal 2000000
    end

    it "Allows the balance to go to zero" do
      updated_balance = @account.withdraw(@account.balance - 10000)
      updated_balance.must_equal 0
      @account.balance.must_equal 0
    end

    it "Doesn't allow withdraws if account goes below 1000000" do
      @account.withdraw(1000001)
      expected_balance = @account.balance

      proc { @account.withdraw(1) }.must_output (/.+/)
      @account.balance.must_equal expected_balance
    end

    it "Doesn't allow withdraws if num of transactions is >= 6" do
      6.times { @account.withdraw(100) }
      expected_balance = @account.balance

      proc { @account.withdraw(1) }.must_output (/.+/)
      @account.balance.must_equal expected_balance
    end
  end

  describe "#deposit" do
    it "Doesn't allow deposits if num of transactions is >= 6" do
      6.times { @account.deposit(100) }
      expected_balance = @account.balance

      proc { @account.deposit(1) }.must_output (/.+/)
      @account.balance.must_equal expected_balance
    end

    it "Doesn't count as a transaction if it causes balance to exceed min" do
      @account.withdraw(1500000)
      @account.deposit(1600000)
      4.times { @account.deposit(100) }
      proc { @account.deposit(300) }.must_be_silent
    end

    it "Doesn't count as a transaction if it causes balance to reach min" do
      @account.withdraw(1500000)
      @account.deposit(1500000)
      4.times { @account.deposit(100) }
      proc { @account.deposit(300) }.must_be_silent
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      @account.add_interest(0.25).must_equal 5000
    end

    it "Updates the balance with calculated interest" do
      @account.add_interest(0.35)
      @account.balance.must_equal 2007000
    end

    it "Requires a positive rate" do
      proc { @account.add_interest(0) }.must_raise ArgumentError
      proc { @account.add_interest(-5) }.must_raise ArgumentError
    end
  end

  describe "#reset_transactions" do
    it "Can be called without error" do
      @account.reset_transactions.must_equal 0
    end

    it "Allows 6 transactions if less than 6 transactions had occurred" do
      @account.withdraw(100)
      @account.reset_transactions
      5.times { @account.deposit(300) }

      proc { @account.withdraw(50) }.must_be_silent
    end

    it "Allows 6 transactions if more than 6 transactions had occurred" do
      8.times { @account.deposit(100) }
      @account.reset_transactions
      5.times { @account.withdraw(50) }

      proc { @account.deposit(400) }.must_be_silent
    end
  end
end
