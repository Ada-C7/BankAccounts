require_relative 'spec_helper.rb'
require_relative '../lib/checking_account'

describe "CheckingAccount" do
  before do
    @account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
  end

  describe "#initialize" do
    it "Is a kind of Account" do
      @account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do

    # I am interpreting 100 as $1.00
    it "Applies a $1 fee each time" do
      start_balance = @account.balance
      @account.withdraw(1000)
      expected_balance = start_balance - 1000 - 100

      @account.balance.must_equal expected_balance
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      updated_balance = @account.withdraw(9901)
      updated_balance.must_equal 10000
      @account.balance.must_equal 10000
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      start_balance = @account.balance
      @account.withdraw_using_check(2500)
      expected_balance = start_balance - 2500

      @account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = @account.balance
      updated_balance = @account.withdraw_using_check(2300)
      expected_balance = start_balance - 2300

      updated_balance.must_equal expected_balance
    end

    it "Allows the balance to go down to -$10" do
      @account.withdraw_using_check(11000)
      @account.balance.must_equal(-1000)
    end

    it "Outputs a warning if the account would go below -$10" do
      proc { @account.withdraw_using_check(11001) }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      @account.withdraw_using_check(11001)
      @account.balance.must_equal 10000
    end

    it "Requires a positive withdrawal amount" do
      proc { @account.withdraw_using_check(0) }.must_raise ArgumentError
      proc { @account.withdraw_using_check(-5) }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      original_balance = @account.balance

      @account.withdraw_using_check(100)
      @account.withdraw_using_check(250)
      @account.withdraw_using_check(1000)

      @account.balance.must_equal (original_balance - 100 - 250 - 1000)
    end

    it "Applies a $2 fee after the third use" do
      original_balance = @account.balance

      @account.withdraw_using_check(100)
      @account.withdraw_using_check(250)
      @account.withdraw_using_check(1000)
      @account.withdraw_using_check(100)

      @account.balance.must_equal (original_balance - 100 - 250 - 1000 - 100 - 200)
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      @account.reset_checks.must_equal 0
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      @account.withdraw_using_check(100)
      balance_before_reset = @account.balance

      @account.reset_checks
      @account.withdraw_using_check(250)
      @account.withdraw_using_check(475)
      @account.withdraw_using_check(1000)

      @account.balance.must_equal (balance_before_reset - 250 - 475 - 1000)

    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      @account.withdraw_using_check(100)
      @account.withdraw_using_check(200)
      @account.withdraw_using_check(50)
      @account.withdraw_using_check(10)

      balance_before_reset = @account.balance

      @account.reset_checks
      @account.withdraw_using_check(30)
      @account.withdraw_using_check(340)
      @account.withdraw_using_check(950)

      @account.balance.must_equal (balance_before_reset - 30 - 340 - 950)
    end
  end
end
