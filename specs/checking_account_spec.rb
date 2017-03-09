require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'


describe "CheckingAccount" do
  before do
    @account = Bank::CheckingAccount.new(12345, 100.0)
  end

  describe "#initialize" do
    it "Is a kind of Account" do
      @account.must_be_kind_of Bank::Account
      @account.must_be_kind_of Bank::CheckingAccount
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      @account.withdraw(10).must_equal 89
      @account.balance.must_equal 89
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      @account.withdraw(100).must_equal 100
      @account.balance.must_equal 100
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      @account.withdraw_using_check(10)
      @account.balance.must_equal 90
    end

    it "Returns the modified balance" do
      @account.withdraw_using_check(10).must_equal 90
    end

    it "Allows the balance to go down to -$10" do
      @account.withdraw_using_check(109).must_equal(-9)
      @account.withdraw_using_check(1).must_equal(-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      proc{
        @account.withdraw_using_check(111)
      }.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
        @account.withdraw_using_check(111)
        @account.balance.must_equal 100
    end

    it "Requires a positive withdrawal amount" do
      proc{
        @account.withdraw_using_check(0)
      }.must_raise ArgumentError
      proc{
        @account.withdraw_using_check(-1)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)
      @account.balance.must_equal 70
    end

    it "Applies a $2 fee after the third use" do
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)
      @account.balance.must_equal 58
      @account.withdraw_using_check(10)
      @account.balance.must_equal 46
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      @account.reset_checks
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      @account.withdraw_using_check(10)
      @account.balance.must_equal 90
      @account.reset_checks
      @account.withdraw_using_check(10)
      @account.balance.must_equal 80
      @account.withdraw_using_check(10)
      @account.balance.must_equal 70
      @account.withdraw_using_check(10)
      @account.balance.must_equal 60
      @account.withdraw_using_check(10)
      @account.balance.must_equal 48
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)
      @account.balance.must_equal 58
      @account.reset_checks
      @account.withdraw_using_check(10)
      @account.balance.must_equal 48
      @account.withdraw_using_check(10)
      @account.balance.must_equal 38
      @account.withdraw_using_check(10)
      @account.balance.must_equal 28
      @account.withdraw_using_check(10)
      @account.balance.must_equal 16
    end

    it "Checking fee cannot bring the balance below -10" do
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)
      @account.withdraw_using_check(10)

      proc{
        @account.withdraw_using_check(80)
      }.must_output(/.+/)
      @account.balance.must_equal 70
    end
  end
end
