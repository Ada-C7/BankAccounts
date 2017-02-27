require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'

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

    #Chris's method
    before do
      @account = Bank::CheckingAccount.new(12345, 100.0)
      @starting_balance = @account.balance
    end

    it "Applies a $1 fee each time" do
      # TODO: Your test code here!
      @account.withdraw(5).must_equal @starting_balance - 6
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      # TODO: Your test code here!
      withdrawal_amount = 100
      proc {
        @account.withdraw(withdrawal_amount)
      }.must_output(/.+/)

      @account.balance.must_equal @starting_balance
    end
  end

  describe "#withdraw_using_check" do

    #Chris's method
    before do
      @account = Bank::CheckingAccount.new(12345, 100.0)
      @starting_balance = @account.balance
    end

    it "Reduces the balance" do
      # TODO: Your test code here!
      @account.withdraw_using_check(25)
      @account.balance.must_equal @starting_balance - 25
    end

    it "Returns the modified balance" do
      # TODO: Your test code here!
      @account.withdraw_using_check(25)
      @account.balance.must_equal @starting_balance - 25

    end

    it "Allows the balance to go down to -$10" do
      # TODO: Your test code here!
      @account.withdraw_using_check(@account.balance + 10.0).must_equal (-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      # TODO: Your test code here!
      proc {
        @account.withdraw_using_check(@starting_balance + 15)
      }.must_raise ArgumentError
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # TODO: Your test code here!
      @account.balance.must_equal @starting_balance
    end

    it "Requires a positive withdrawal amount" do
      # TODO: Your test code here!
      proc {
        @account.withdraw_using_check(-25)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      # TODO: Your test code here!
      3.times do
        @account.withdraw_using_check(10)
      end
      @account.balance.must_equal @starting_balance - 30
    end

    it "Applies a $2 fee after the third use" do
      # TODO: Your test code here!
      4.times do
        @account.withdraw_using_check(10)
      end
      @account.balance.must_equal @starting_balance - 42
    end
  end

  describe "#reset_checks" do

    #Chris's method
    before do
      @account = Bank::CheckingAccount.new(12345, 100.0)
      @starting_balance = @account.balance
    end

    it "Can be called without error" do
      # TODO: Your test code here!
      @account.reset_checks
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # TODO: Your test code here!
      @account.withdraw_using_check(10)
      @account.reset_checks
      3.times do
        @account.withdraw_using_check(10)
      end

      @account.balance.must_equal @starting_balance - 40
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # TODO: Your test code here!
      4.times do
        @account.withdraw_using_check(10)
      end
      @account.reset_checks
      3.times do
        @account.withdraw_using_check(10)
      end
      @account.balance.must_equal @starting_balance - 72

    end
  end
end
