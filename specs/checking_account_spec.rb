require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

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
    it "Applies a $1 fee each time" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw(50).must_equal 49
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      new_balance = account.withdraw(100)
      new_balance.must_equal 100
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      new_balance = account.withdraw_using_check(10)
      new_balance.must_equal 90
    end

    it "Returns the modified balance" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      new_balance = account.withdraw_using_check(10)
      new_balance.must_equal 90
    end

    it "Allows the balance to go down to -$10" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      new_balance = account.withdraw_using_check(110)
      new_balance.must_equal (-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      proc {
        account.withdraw_using_check(111)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      new_balance = account.withdraw_using_check(111)
      new_balance.must_equal 100
    end

    it "Requires a positive withdrawal amount" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      proc {
        account.withdraw_using_check(-1)
      }.must_output (/.+/)
    end

    it "Allows 3 free uses" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.balance.must_equal 70
    end

    it "Applies a $2 fee after the third use" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.balance.must_equal 58
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.reset_checks.must_equal "reset"
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.reset_checks
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.balance.must_equal 50
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.reset_checks
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.withdraw_using_check(10)
      account.balance.must_equal 28
    end
  end
end
