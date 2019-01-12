require_relative 'spec_helper.rb'
require_relative '../lib/savings_account'

describe "SavingsAccount" do
  before do
    @account = Bank::SavingsAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
  end
  describe "#initialize" do
    it "Is a kind of Account" do
      @account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(12345, 100, "1999-03-27 11:30:09 -0800")
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do

    #interpreting 200 as $2.00
    it "Applies a $2 fee each time" do
      start_balance = @account.balance
      @account.withdraw(1000)
      expected_balance = start_balance - 1000 - 200

      @account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the balance would go below $10" do
      proc { @account.withdraw(9100) }.must_output (/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      updated_balance = @account.withdraw(9500)
      updated_balance.must_equal 10000
      @account.balance.must_equal 10000
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      updated_balance = @account.withdraw(8801)
      updated_balance.must_equal 10000
      @account.balance.must_equal 10000
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      @account.add_interest(0.25).must_equal 25
    end

    it "Updates the balance with calculated interest" do
      @account.add_interest(0.35)
      @account.balance.must_equal 10035
    end

    it "Requires a positive rate" do
      proc { @account.add_interest(0) }.must_raise ArgumentError
      proc { @account.add_interest(-5) }.must_raise ArgumentError
    end
  end
end
