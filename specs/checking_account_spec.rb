require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do
  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    before do
      @my_checking = Bank::CheckingAccount.new(1234, 500.00)
    end

    it "Applies a $1 fee each time" do
      @my_checking.withdraw(10)
      @my_checking.balance.must_equal(489)
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      updated_balance = @my_checking.withdraw(500.00)

      #Both the value returned and balance in account
      #must be un-modified
      updated_balance.must_equal 500
      @my_checking.balance.must_equal 500
    end

  end

  describe "#withdraw_using_check" do
    before do
      @my_checking = Bank::CheckingAccount.new(1234, 500.00)
    end

    it "Reduces the balance" do
      @my_checking.withdraw_using_check(20)
      @my_checking.balance.must_equal(480)
    end

    it "Returns the modified balance" do
      modified_balance = @my_checking.withdraw_using_check(20)

      modified_balance.must_equal(480)
    end

    it "Allows the balance to go down to -$10" do
      @my_checking.withdraw_using_check(510)
    end

    it "Outputs a warning if the account would go below -$10" do
      proc { @my_checking.withdraw_using_check(520) }.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      @my_checking.withdraw_using_check(520)
      @my_checking.balance.must_equal(500)
    end

    it "Requires a positive withdrawal amount" do
      proc { @my_checking.withdraw_using_check(-25) }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      3.times do
        @my_checking.withdraw_using_check(10)
      end

      @my_checking.balance.must_equal(470)
    end

    it "Applies a $2 fee after the third use" do
      4.times do
        @my_checking.withdraw_using_check(10)
      end

      @my_checking.balance.must_equal(458)
    end
  end

  describe "#reset_checks" do
    before do
      @my_checking = Bank::CheckingAccount.new(1234, 500.00)
    end

    it "Can be called without error" do
      @my_checking.reset_checks
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      2.times do
        @my_checking.withdraw_using_check(10)
      end

      @my_checking.reset_checks

      3.times do
        @my_checking.withdraw_using_check(10)
      end

      @my_checking.balance.must_equal(450)
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      4.times do
        @my_checking.withdraw_using_check(10)
      end

      @my_checking.reset_checks

      3.times do
        @my_checking.withdraw_using_check(10)
      end

      @my_checking.balance.must_equal(428)
      
    end
  end
end
