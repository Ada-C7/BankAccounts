require 'spec_helper'

describe "CheckingAccount" do

  before do
    @account = Bank::CheckingAccount.new(12345, 100.0, nil)
  end

    describe "#initialize" do

      it "Is a kind of Account" do
        @account.must_be_kind_of Bank::Account
      end
    end

    describe "#withdraw" do

      it "Applies a $1 fee each time" do
        @account.withdraw(20)
        @account.balance.must_equal 79
      end

      it "Doesn't modify the balance if the fee would put it negative" do
        proc {@account.withdraw(105.0)}.must_raise ArgumentError
        @account.balance.must_equal 100
      end
    end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      @account.withdraw_using_check(20)
      @account.balance.must_equal 80
    end

    it "Returns the modified balance" do
      @account.withdraw_using_check(20)
      @account.balance.must_equal 80
    end

    it "Allows the balance to go down to -$10" do
      @account.withdraw_using_check(110)
      @account.balance.must_equal(-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      proc {@account.withdraw_using_check(120)}.must_raise ArgumentError
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      proc{@account.withdraw_using_check(120)}.must_raise ArgumentError
      @account.balance.must_equal(100)
    end

    it "Requires a positive withdrawal amount" do
      proc {@account.withdraw_using_check(-10)}.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      3.times do
        @account.withdraw_using_check(10)
      end

      @account.balance.must_equal(70)
    end

    it "Applies a $2 fee after the third use" do
      4.times do
        @account.withdraw_using_check(10)
      end

      @account.balance.must_equal(58)
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      @account.reset_checks
      @account.used_checks.must_equal 0
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      3.times do
        @account.withdraw_using_check(10)
      end

      @account.balance.must_equal(70)
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      3.times do
        @account.withdraw_using_check(10)
      end

      @account.balance.must_equal(70)
    end
  end
end
