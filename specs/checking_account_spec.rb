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
    CH_FEE = 1.00

    before do
      @balance = 100.0
      @account = Bank::CheckingAccount.new(12345, @balance)
    end

    it "Applies a $1 fee each time" do
      withdraw_amount = 25.0
      @account.withdraw(withdraw_amount)
      @account.balance.must_equal 74
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      withdraw_amount = 100.0
      @account.withdraw(withdraw_amount)
      @account.balance.must_equal 100.0
    end
  end

  describe "#withdraw_using_check" do

    before do
      @balance = 100.0
      @account = Bank::CheckingAccount.new(12345, @balance)
    end

    it "Reduces the balance" do
      amount = 10.0
      @account.withdraw_using_check(amount).must_equal 90.0

    end

    it "Returns the modified balance" do
      amount = 10.0
      @account.withdraw_using_check(amount).must_equal 90.0
      @account.balance.must_equal 90.0
    end

    it "Allows the balance to go down to -$10" do
      amount = 110.0
      @account.withdraw_using_check(amount).must_equal (-10.0)
      @account.balance.must_equal (-10.0)
    end

    it "Outputs a warning if the account would go below -$10" do
      amount = 120.0
      proc {
        @account.withdraw_using_check(amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      amount = 120.0
      @account.withdraw_using_check(amount).must_equal 100.0
    end

    it "Requires a positive withdrawal amount" do
      amount = -10.0
      proc {
        @account.withdraw_using_check(amount)
      }.must_output (/.+/)
    end

    it "Allows 3 free uses" do
      amount = 10.0
      # this is what I tried the first time, now using times loop
      # new_balance = @account.withdraw_using_check(amount)
      # new_balance = @account.withdraw_using_check(amount)
      # new_balance = @account.withdraw_using_check(amount)
      new_balance = nil
      3.times do
        new_balance = (@account.withdraw_using_check(amount))
      end
      new_balance.must_equal 70.0
    end

    it "Applies a $2 fee after the third use" do
      amount = 10.0
      new_balance = nil
      4.times do
        new_balance = (@account.withdraw_using_check(amount))
      end
      new_balance.must_equal 58.0
    end
  end

  describe "#reset_checks" do

    before do
      @balance = 100.0
      @account = Bank::CheckingAccount.new(12345, @balance)
    end

    it "Can be called without error" do
      @account.reset_checks.must_equal 0
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      amount = 10.0

      new_balance = nil
      2.times do
        new_balance = (@account.withdraw_using_check(amount))
      end
      new_balance.must_equal 80.0

      @account.reset_checks.must_equal 0

      3.times do
        new_balance = (@account.withdraw_using_check(amount))
      end

      new_balance.must_equal 50.0

    end# end of test

    it "Makes the next three checks free if more than 3 checks had been used" do
      amount = 10.0

      new_balance = nil
      4.times do
        new_balance = (@account.withdraw_using_check(amount))
      end
      new_balance.must_equal 58.0

      @account.reset_checks.must_equal 0

      3.times do
        new_balance = (@account.withdraw_using_check(amount))
      end

      new_balance.must_equal 28.0
    end
  end
end
