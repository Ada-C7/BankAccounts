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
      proc { @account.withdraw(1) }.must_output (/.+/)
    end
  end
end
