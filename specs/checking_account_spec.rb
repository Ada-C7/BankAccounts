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
    it "Applies a $1 fee each time" do
      # TODO: Your test code here!
      start_balance = 100.0
      account = Bank::CheckingAccount.new(12345, start_balance)
      withdraw_amount = 25
      updated_balance = account.withdraw(withdraw_amount)

      updated_balance.must_equal (start_balance - (withdraw_amount + 1))

    end

    it "Doesn't modify the balance if the fee would put it negative" do
      # TODO: Your test code here!

      start_balance = 100.0
      account = Bank::CheckingAccount.new(12345, start_balance)
      withdraw_amount = 100
      updated_balance = account.withdraw(withdraw_amount)

      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance

    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      # TODO: Your test code here!
      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check_amount = 80
      updated_balance = account.withdraw_using_check(check_amount)

      updated_balance.must_equal (start_balance - check_amount)
      updated_balance.must_equal 20

    end

    it "Returns the modified balance" do
      # TODO: Your test code here!

      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check_amount = 80
      updated_balance = account.withdraw_using_check(check_amount)

      account.balance.must_equal updated_balance
      account.balance.must_equal (start_balance - check_amount)
    end

    it "Allows the balance to go down to -$10" do
      # TODO: Your test code here!
      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check_amount = 110.00
      updated_balance = account.withdraw_using_check(check_amount)

      account.balance.must_equal updated_balance
      account.balance.must_equal (start_balance - check_amount)
      account.balance.must_equal -10

    end

    it "Outputs a warning if the account would go below -$10" do
      # TODO: Your test code here!

      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check_amount = 110.01
      # updated_balance = account.withdraw_using_check(check_amount)

      proc { account.withdraw_using_check(check_amount)}.must_output /.+/

    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # TODO: Your test code here!
      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check_amount = 110.01
      updated_balance = account.withdraw_using_check(check_amount)

      updated_balance.must_equal start_balance

    end

    it "Requires a positive withdrawal amount" do
      # TODO: Your test code here!

      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check_amount = -10
      # updated_balance = account.withdraw_using_check(check_amount)

      # updated_balance.must_equal start_balance
      proc { account.withdraw_using_check(check_amount)}.must_raise ArgumentError

    end

    it "Allows 3 free uses" do
      # TODO: Your test code here!

      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check1 = 10
      check2 = 20
      check3 = 40
      # check4 = 5

      account.withdraw_using_check(check1).must_equal 90
      account.withdraw_using_check(check2).must_equal 70
      account.withdraw_using_check(check3).must_equal 30

    end

    it "Applies a $2 fee after the third use" do
      # TODO: Your test code here!
      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check1 = 10
      check2 = 20
      check3 = 40
      check4 = 5

      account.withdraw_using_check(check1).must_equal 90
      account.withdraw_using_check(check2).must_equal 70
      account.withdraw_using_check(check3).must_equal 30
      account.withdraw_using_check(check4).must_equal 23


    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      # TODO: Your test code here!

      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check1 = 10
      check2 = 20
      check3 = 40
      check4 = 5

      account.withdraw_using_check(check1)

      account.check_count.must_equal 1
      account.withdraw_using_check(check2)
      account.check_count.must_equal 2

      account.reset_checks
      account.check_count.must_equal 0

    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # TODO: Your test code here!

      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check1 = 5
      check2 = 10
      check3 = 10
      check4 = 5
      check5 = 3
      check6 = 2

      account.withdraw_using_check(check1)
      account.withdraw_using_check(check2)
      account.reset_checks
      account.withdraw_using_check(check3)
      account.withdraw_using_check(check4)
      account.withdraw_using_check(check5).must_equal 67
      account.withdraw_using_check(check6).must_equal 63

      account.check_count.must_equal 4
    end

    it "Makes the next three checks free if more than 3 checks had been used" do

      start_balance = 100.0
      account = Bank::CheckingAccount.new(1235, start_balance)
      check1 = 5
      check2 = 10
      check3 = 10
      check4 = 5
      check5 = 3
      check6 = 2
      check7 = 4
      check8 = 11


      account.withdraw_using_check(check1)
      account.withdraw_using_check(check2)
      account.withdraw_using_check(check3)
      account.withdraw_using_check(check4)

      account.balance.must_equal 68
      account.check_count.must_equal 4

      account.reset_checks

      account.check_count.must_equal 0

      account.withdraw_using_check(check5)
      account.withdraw_using_check(check6)
      account.withdraw_using_check(check7)

      account.balance.must_equal 59
      account.check_count.must_equal 3

      account.withdraw_using_check(check8)
      account.balance.must_equal 46

      # TODO: Your test code here!
    end
  end
end
