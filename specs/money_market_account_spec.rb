require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/money_market_account'

describe "Bank::MoneyMarketAccount" do

  describe "#initialize" do
    #Check that MoneyMarketAccount is a kind of account
    it "Check#Initialize" do
      account = Bank::MoneyMarketAccount.new(123, 10000.00, "5/5/5")
      account.must_be_kind_of Bank::Account
    end

    it "Initial balance must be > 10k" do
    #initial balance cannot be less than 10,000.  This will raise an ArgumentError
      proc { Bank::MoneyMarketAccount.new(1337, 9999) }.must_raise ArgumentError
    end

  end

  describe "transactions" do
    before do
      @my_money_market = Bank::MoneyMarketAccount.new(1234, 1000000.00)
    end

    it "Does not allow more than six withdrawals" do
      #Maximum of 6 transactions allowed per month
      6.times do
        @my_money_market.withdraw(10)
      end

      #7th transaction should raise error
      proc { @my_money_market.withdraw(10) }.must_raise ArgumentError
    end

    it "Does not allow more than six deposits" do
      #Maximum of 6 transactions allowed per month
      6.times do
        @my_money_market.deposit(10)
      end

      #7th transaction should raise error
      proc { @my_money_market.deposit(10) }.must_raise ArgumentError
    end

    it "Does not allow more than six mixed deposits and withdrawals together" do
      #Maximum of 6 transactions allowed per month
      3.times do
        @my_money_market.deposit(10)
      end

      3.times do
        @my_money_market.withdraw(10)
      end

      #7th transaction should raise error
      proc { @my_money_market.deposit(10) }.must_raise ArgumentError
    end

  end

  describe "transactions" do
    before do
      @my_money_market = Bank::MoneyMarketAccount.new(1234, 10000.00)
    end

    it "if withdrawal takes balance below 10k, charges a fee of $100" do
      @my_money_market.withdraw(500)

      @my_money_market.balance.must_equal(9400)
    end

    it "if withdrawal goes below 10k, no more transactions are allowed" do
      @my_money_market.withdraw(500)

      proc { @my_money_market.withdraw(500) }.must_raise ArgumentError
    end

    it "if withdrawal goes below 10k, then deposit goes above 10k, should be allow to withdraw again" do
      @my_money_market.withdraw(500)
      @my_money_market.deposit(1000)
      #should not raise an issue.
      @my_money_market.withdraw(10)
    end

    it "all transactions count towards 6 transactions, except for deposit to bring balance back up to 10k" do
      @my_money_market.withdraw(500)
      @my_money_market.deposit(1000)
      #should not raise an issue.
      @my_money_market.withdraw(10)
      @my_money_market.total_transactions.must_equal(2)
    end

  end

  describe "#reset_transactions" do
    before do
      @my_money_market = Bank::MoneyMarketAccount.new(1234, 100000.00)
    end

    it "resets total_transactions to 0" do

    3.times do
      @my_money_market.withdraw(10)
    end

    @my_money_market.reset_transactions

    @my_money_market.total_transactions.must_equal(0)

    end

    describe "#add_interest" do
      before do
        @my_money_market = Bank::MoneyMarketAccount.new(1234, 10000.00)
        @my_interest = @my_money_market.add_interest(0.25)
      end

      it "Returns the interest calculated" do
        @my_interest.must_equal(25)
      end

      it "Updates the balance with calculated interest" do
        @my_money_market.balance.must_equal(10025.00)
      end

      it "Requires a positive rate" do
        proc { @my_money_market.add_interest(-0.25) }.must_raise ArgumentError
      end

    end

  end
end



# Add interest same as to SavingsAccount
# Inputs are interest rate, balance
# Outputs are updated balance, returning interest earned.
