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
      id = 12345
      balance = 100.0
      account = Bank::CheckingAccount.new(id, balance)
      account.must_be_kind_of Bank::Account

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance
    end
  end
end

describe "#withdraw" do
  it "Applies a $1 fee each time" do
    # TODO: Your test code here!
    start_balance = 100.0
    withdrawal_amount = 25.0
    account = Bank::CheckingAccount.new(12345, start_balance)

    account.withdraw(withdrawal_amount)

    expected_balance = start_balance - (withdrawal_amount+1)
    account.balance.must_equal expected_balance
  end

  it "Doesn't modify the balance if the fee would put it negative" do
    # TODO: Your test code here!
    start_balance = 100.0
    withdrawal_amount = 100.0
    account = Bank::CheckingAccount.new(12345, start_balance)

    updated_balance = account.withdraw(withdrawal_amount)

    # Both the value returned and the balance in the account
    # must be un-modified.
    updated_balance.must_equal start_balance
    account.balance.must_equal start_balance
  end
end

describe "#withdraw_using_check" do
  describe "when withdrawing less than the balance" do
    it "Reduces the balance" do
      # TODO: Your test code here!
      start_balance = 100.0
      checking_account = Bank::CheckingAccount.new(12345, start_balance)
      end_balance = checking_account.withdraw_using_check(75)
      end_balance.must_equal 25
    end

    it "Doesn't print anything" do
      # TODO: Your test code here!
      start_balance = 100.0
      checking_account = Bank::CheckingAccount.new(12345, start_balance)
      proc{checking_account.withdraw_using_check(75)}.must_be_silent
    end
  end
  describe "when withdrawing goes into overdraft" do
    it "Reduces the balance" do
      # TODO: Your test code here!
      start_balance = 100.0
      checking_account = Bank::CheckingAccount.new(12345, start_balance)
      end_balance = checking_account.withdraw_using_check(105)
      end_balance.must_equal -5
    end
    it "Doesn't print anything" do
      # TODO: Your test code here!
      start_balance = 100.0
      checking_account = Bank::CheckingAccount.new(12345, start_balance)
      proc{checking_account.withdraw_using_check(105)}.must_be_silent
    end
  end
  describe "when withdrawing goes beyond overdraft limit" do
    it "Doesn't reduce the balance" do
      # TODO: Your test code here!
      start_balance = 100.0
      checking_account = Bank::CheckingAccount.new(12345, start_balance)
      end_balance = checking_account.withdraw_using_check(111)
      end_balance.must_equal 100
    end
    it "Prints a warning" do
      # TODO: Your test code here!
      start_balance = 100.0
      checking_account = Bank::CheckingAccount.new(12345, start_balance)
      proc{checking_account.withdraw_using_check(111)}.must_output "Warning: insufficient fund.\n"
    end
  end
      it "Requires a positive withdrawal amount" do
        start_balance = 0
        checking_account = Bank::CheckingAccount.new(12345, start_balance)
        proc{checking_account.withdraw_using_check(-10)}.must_raise ArgumentError
      end

      it "Allows 3 free uses" do
        start_balance = 100
        checking_account = Bank::CheckingAccount.new(12345, start_balance)
        3.times {checking_account.withdraw_using_check(10)}
        checking_account.balance.must_equal start_balance - 30
      end

      it "Applies a $2 fee after the third use" do
        start_balance = 100
        checking_account = Bank::CheckingAccount.new(12345, start_balance)
        4.times {checking_account.withdraw_using_check(10)}
        checking_account.balance.must_equal start_balance - 42
      end
    end

    describe "#reset_checks" do
      it "Can be called without error" do
        start_balance = 100
        checking_account = Bank::CheckingAccount.new(12345, start_balance)
        proc{checking_account.reset_checks}.must_be_silent
      end


      it "Makes the next three checks free if less than 3 checks had been used" do
        start_balance = 100
        checking_account = Bank::CheckingAccount.new(12345, start_balance)
        2.times {checking_account.withdraw_using_check(10)}
        checking_account.reset_checks
        3.times {checking_account.withdraw_using_check(10)}
        checking_account.balance.must_equal start_balance - 50
end

      it "Makes the next three checks free if more than 3 checks had been used" do
        start_balance = 100
        checking_account = Bank::CheckingAccount.new(12345, start_balance)
        4.times {checking_account.withdraw_using_check(10)}
        checking_account.reset_checks
        3.times {checking_account.withdraw_using_check(10)}
        checking_account.balance.must_equal start_balance - 72
end
    end
