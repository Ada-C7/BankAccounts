require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/money_market'


describe "MoneyMarketAccount" do
  describe "#initialize" do

    it "Is a kind of Account" do
      account = Bank::MoneyMarketAccount.new(12345, 10000)
      account.must_be_kind_of Bank::Account
    end

    it "Must be initialized with a balance of $10,000" do
      proc {
        Bank::MoneyMarketAccount.new(12345, 9999)
      }.must_raise ArgumentError
    end

  end

  describe "#withdrawal" do

    it "Imposes a $100 fee if the balance goes below $10,000" do
      account = Bank::MoneyMarketAccount.new(12345, 10000)
      account.withdraw(500)
      account.balance.must_equal 9400
    end

    it "Doesn't allow anymore transactions if the balance goes below $10000" do
      account = Bank::MoneyMarketAccount.new(12345, 10000)
      account.withdraw(500)
      proc {
        account.withdraw(500)
      }.must_output(/.+/)
      account.balance.must_equal 9400
    end

    it "Doesn't allow transactions if user has used all transaction" do
      account = Bank::MoneyMarketAccount.new(12345, 20000)
      6.times do
        account.withdraw(50)
      end
      proc {
        account.withdraw(50)
      }.must_raise ArgumentError
    end
  end

  describe "#deposits" do
    it "Each transaction will be counted against the maximum number of transactions" do
      account = Bank::MoneyMarketAccount.new(1337, 10000.0)
      account.deposit(500)
      account.transactions.must_equal 5
    end

    it " A deposit performed to reach or exceed the minimum balance of $10,000
    is not counted as part of the 6 transactions." do
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      skip
      account = Bank::MoneyMarketAccount.new(1337, 10000.0)
      account.interest(0.25).must_equal 25.0
    end

    it "Updates the balance with calculated interest" do
      skip
      account = Bank::MoneyMarketAccount.new(1337, 10000.0)
      account.interest(0.25)
      account.balance.must_equal 10025
    end

    it "Requires a positive rate" do
      skip
      account = Bank::MoneyMarketAccount.new(1337, 10000.0)
      proc {
        account.interest(-0.25)
      }.must_raise ArgumentError
    end
  end

  describe "reset_transactions" do
    it "Can be called without error" do
      skip
      account = Bank::MoneyMarket.new(1337, 10000.0)
      account.must_respond_to :reset_transactions
    end

    it "Resets transaction count" do
    end

  end

end
