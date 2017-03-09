require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

describe "SavingsAccount" do
  before do
    @savings_account = Bank::SavingsAccount.new(12345, 10000)
  end

  describe "#initialize" do
    it "Is a kind of Account" do
      @savings_account.must_be_kind_of Bank::Account
      @savings_account.must_be_kind_of Bank::SavingsAccount #this is enforcing the inheritance
    end




    it "Requires an initial balance of at least $10" do
      proc{
        Bank::SavingsAccount.new(1111, 9)
      }.must_raise ArgumentError

        Bank::SavingsAccount.new(1111, 10)
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      @savings_account.withdraw(10).must_equal 10000 - 10 - 2
    end

    it "Outputs a warning if the balance would go below $10" do
      proc {
        @savings_account.withdraw(10000 - 11)
      }.must_output(/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      @savings_account.withdraw(10000 - 9)
      @savings_account.balance.must_equal 10000.00
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      @savings_account.withdraw(10000 - 11)
      @savings_account.balance.must_equal 10000.00
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      @savings_account.add_interest(0.25).must_equal 25.0
    end

    it "Updates the balance with calculated interest" do
      @savings_account.add_interest(0.25).must_equal 25.0
      @savings_account.balance.must_equal 10025.0
    end

    it "Requires a positive rate" do
      proc {
        @savings_account.add_interest(0)
      }.must_raise ArgumentError
      proc {
        @savings_account.add_interest(-0.25)
      }.must_raise ArgumentError

    end
  end
end
