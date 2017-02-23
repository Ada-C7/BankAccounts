require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw(50)
      account.balance.must_equal 49.0
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      account = Bank::CheckingAccount.new(1337, 100.0)
      account.withdraw(100)
      account.balance.must_equal 100.0
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      account = Bank::CheckingAccount.new(1337, 100.0)
      account.withdraw_using_check(50)
      account.balance.must_equal 50.0
    end

    it "Returns the modified balance" do
      account = Bank::CheckingAccount.new(1337, 100.0)

      updated_balance = account.withdraw_using_check(25.0)

      expected_balance = 75.0
      updated_balance.must_equal expected_balance
    end

    it "Allows the balance to go down to -$10" do
      account = Bank::CheckingAccount.new(1337, 100.0)
      account.withdraw_using_check(110)
      account.balance.must_equal -10.0
    end

    it "Outputs a warning if the account would go below -$10" do
      account = Bank::CheckingAccount.new(1337, 100.0)
      proc {
        account.withdraw_using_check(111)
      }.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      account = Bank::CheckingAccount.new(1337, 100.0)
      account.withdraw_using_check(111)
      account.balance.must_equal 100.0
    end

    it "Requires a positive withdrawal amount" do
      account = Bank::CheckingAccount.new(1337, 100.0)
      proc {
        account.withdraw_using_check(-25)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      account = Bank::CheckingAccount.new(1337, 100.0)
      account.withdraw_using_check(20)
      account.withdraw_using_check(20)
      account.withdraw_using_check(20)
      account.balance.must_equal 40.0
    end

    it "Applies a $2 fee after the third use" do
      account = Bank::CheckingAccount.new(1337, 100.0)
      account.withdraw_using_check(20)
      account.withdraw_using_check(20)
      account.withdraw_using_check(20)
      account.withdraw_using_check(20)
      account.balance.must_equal 18.0
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      skip
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      skip
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      skip
      # TODO: Your test code here!
    end
  end
end
