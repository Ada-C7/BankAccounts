require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'


describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(id: 12345, balance: 100)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(id: 12345, balance: 9)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    before do
      @account = Bank::SavingsAccount.new(id: 12345, balance: 100)
    end

    it "Applies a $2 fee each time" do
      @account.withdraw(10)
      @account.balance.must_equal 88
    end

    it "Outputs a warning & doesn't modify the balance if it would go below $10" do
      proc {
        @account.withdraw(90)
      }.must_output(/.+/)

      @account.balance.must_equal 100
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      proc {
        @account.withdraw(90)
      }.must_output(/.+/)

      @account.balance.must_equal 100
    end
  end

  describe "#add_interest" do
    before do
      @account = Bank::SavingsAccount.new(id: 12345, balance: 10000)
    end

    it "Returns the interest calculated" do
      @account.add_interest(0.25).must_equal 25
    end

    it "Updates the balance with calculated interest" do
      @account.add_interest(0.25)
      @account.balance.must_equal 10025
    end

    it "Requires a positive rate" do
      proc {
        @account.add_interest(-0.25)
      }.must_raise ArgumentError
    end
  end
end
