require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/checking'

describe "CheckingAccount" do

  before do
      @account = Bank::CheckingAccount.new(12345, 100.0, "Jan 1, 2017")
  end

  describe "#initialize" do
    it "Is a kind of Account" do
      @account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      @account.withdraw(50)
      @account.balance.must_equal 49.0
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      starting_balance = @account.balance
      updated_balance = @account.withdraw(100)
      updated_balance.must_equal starting_balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      @account.withdraw_using_check(40).must_equal 100 - 40
    end

    it "Returns the modified balance" do
      @account.withdraw_using_check(40).must_equal 60
    end

    it "Allows the balance to go down to -$10" do
      @account.withdraw_using_check(110).must_equal (-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      proc {
        @account.withdraw(150)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      starting_balance = @account.balance
      updated_balance = @account.withdraw_using_check(150)
      updated_balance.must_equal starting_balance
    end

    it "Requires a positive withdrawal amount" do
      proc {
        @account.withdraw_using_check(-25)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      3.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal 70
    end

    it "Applies a $2 fee after the third use" do
      4.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal 58
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      @account.must_respond_to :reset_checks
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      2.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal 80
      @account.reset_checks
      3.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal 50
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      4.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal 58
      @account.reset_checks
      @account.withdraw_using_check(10)
      @account.balance.must_equal 48
    end
  end
end
