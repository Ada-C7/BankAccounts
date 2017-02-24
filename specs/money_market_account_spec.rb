require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/money_market_account'


describe "MoneyMarketAccount" do
  before do
    @account = Bank::MoneyMarketAccount.new(id: 12345, balance: 20000.0)
    @starting_balance = @account.balance
  end

  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      @account.must_be_kind_of Bank::Account
    end

    it "Doesnt allow a balance below $10,000" do
      proc {
        Bank::MoneyMarketAccount.new(id: 12344, balance: 1)
      }.must_raise ArgumentError
    end

  end

  describe "transactions (withdrawals & deposits)" do
    it "Does not allow over 6 transactions in a month" do
      proc {
        3.times { @account.deposit(10) }
        4.times { @account.deposit(10) }
      }.must_raise ArgumentError
    end
  end

  describe "#deposit" do

    it "Counts a transaction when money is deposited" do
      @account.deposit(1000)
      @account.transaction_count.must_equal 1
    end

    it "Allows 7th transaction in a month if it brings account to above minimum" do
      6.times { @account.withdraw(2000) }
      @account.deposit(3000)

      # Expect balance to be original, less withdrawals, deposits and $100 fee
      target_balance = @starting_balance - 12000 - 100 + 3000

      @account.balance.must_equal target_balance
    end
  end

  describe "#withdraw" do

    it "Counts a transaction when money is withdrawn" do
      @account.withdraw(1000)
      @account.transaction_count.must_equal 1
    end

    it "Charges a fee of $100 if withdrawal brings account below minimum balance" do
      @account.withdraw(11000)
      target_balance = @starting_balance - 11000 - 100
      @account.balance.must_equal target_balance
    end

    it "Does not allow withdrawals if the account is below minimum balance" do
      @account.withdraw(11000)
      proc { @account.withdraw(10) }.must_raise ArgumentError
    end
  end

  describe "#add_interest" do

    it "Returns the interest calculated" do
      @account.add_interest(0.25).must_equal 50
    end

    it "Updates the balance with calculated interest" do
      @account.add_interest(0.25)
      @account.balance.must_equal 20050
    end

    it "Requires a positive rate" do
      proc {
        @account.add_interest(-0.25)
      }.must_raise ArgumentError
    end
  end

  describe "#reset_transactions" do
    it "Resets transactions" do
      @account.deposit(100)
      @account.reset_transactions
      @account.transaction_count.must_equal 0
    end
  end

end
