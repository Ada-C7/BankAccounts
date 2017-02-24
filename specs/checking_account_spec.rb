require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

describe "CheckingAccount" do
  before do
    @account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
  end
  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      @account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do

    # I am interpreting 100 as $100
    it "Applies a $1 fee each time" do
      start_balance = @account.balance
      withdrawal_amount = 1000

      @account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount - 100
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
      withdrawal_amount = 2500

      @account.withdraw_using_check(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      @account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = @account.balance
      withdrawal_amount = 2300

      updated_balance = @account.withdraw_using_check(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
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
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # TODO: Your test code here!
    end
  end
end
