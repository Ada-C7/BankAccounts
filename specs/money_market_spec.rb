require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/money_market'

describe "MoneyMarket" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a MoneyMarket is in fact a kind of account
      account = Bank::MoneyMarket.new(12345, 15000.00)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10000" do
      proc {
        Bank::MoneyMarket.new(1337, 9999)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $100 fee when the balance goes below $10000" do
      account = Bank::MoneyMarket.new(1337, 15000.0)
      account.withdraw(5001)
      account.balance.must_equal 9899
    end

    it "No more transactions allowed after 6 transactions" do
      account = Bank::MoneyMarket.new(1337, 15000.0)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.balance.must_equal 14940
    end
  end

  describe "#deposit" do
    it "The deposit transaction made to push balance over 0 is not counted in max 6 transactions per month " do
      account = Bank::MoneyMarket.new(12345, 10000)
      account.deposit(10)
      account.deposit(10)
      account.deposit(10)
      account.deposit(10)
      account.withdraw(30)
      account.withdraw(30)
      account.deposit(200)
      account.balance.must_equal 10080
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      account = Bank::MoneyMarket.new(12345, 15000.0)
      interest = account.add_interest(0.25)
      interest.must_equal 3750
    end

    it "Updates the balance with calculated interest" do
      account = Bank::MoneyMarket.new(12345, 15000.0)
      account.add_interest(0.25)
      account.balance.must_equal 18750
    end

    it "Requires a positive rate" do
      account = Bank::MoneyMarket.new(12345, 15000.0)
      proc {
        account.add_interest(-0.25)
      }.must_output (/.+/)
    end
  end

  describe "#reset_transactions" do
    it "Setting the number of transactions to 0" do
      account = Bank::MoneyMarket.new(12345, 10000.0)
      account.deposit(10)
      account.deposit(10)
      account.deposit(10)
      account.deposit(10)
      account.withdraw(30)
      account.withdraw(30)
      account.deposit(200) #10080
      account.deposit(20)
      account.reset_transactions
      account.deposit(20)
      account.balance.must_equal 10100
    end
  end

end
