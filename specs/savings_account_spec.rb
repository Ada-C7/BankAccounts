require_relative 'spec_helper.rb'

describe "SavingsAccount" do

  describe "#initialize" do

    it "Is a kind of Account" do
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc{Bank::SavingsAccount.new(12345, 5)}.must_raise ArgumentError
    end

  end

  describe "#withdraw" do

    before do
      @account = Bank::SavingsAccount.new(12345, 100.0)
    end

    it "Applies a $2 fee each time" do
      @account.withdraw(10)
      @account.balance.must_equal(88)
    end

    it "Outputs a warning if the balance would go below $10" do
      proc {@account.withdraw(95)}.must_raise ArgumentError
    end

    it "Doesn't modify the balance if it would go below $10" do
      proc {@account.withdraw(95)}.must_raise ArgumentError
      @account.balance.must_equal 100
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      proc {@account.withdraw(89)}.must_raise ArgumentError
      @account.balance.must_equal 100
    end
  end

  describe "#add_interest" do

    before do
      @account = Bank::SavingsAccount.new(12345, 100.0)
    end

    it "Returns the interest calculated" do
      @account.add_interest(0.25)
      @account.interest.must_equal(0.25)
    end

    it "Updates the balance with calculated interest" do
      @account.add_interest(0.25)
      @account.balance.must_equal(100.25)
    end

    it "Requires a positive rate" do
      proc {@account.add_interest(-0.25)}.must_raise ArgumentError
    end
  end
end
