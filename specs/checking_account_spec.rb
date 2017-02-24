require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'
require 'time'

describe "CheckingAccount" do
  describe "Checking#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0, "1999-03-27 11:30:09 -0800")
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      fee = 1.0
      account = Bank::CheckingAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - (withdrawal_amount + fee)
      account.balance.must_equal expected_balance
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      start_balance = 100.0
      withdrawal_amount = 110.0 # consider $10 overdraft
      hidden_fee = 1.0
      account = Bank::CheckingAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      start_balance = 100.0
      check_1 = 10.0
      account = Bank::CheckingAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      account.withdraw_using_check(check_1)
      expected_balance = start_balance - check_1

      account.balance.must_equal expected_balance
    end

    it "Allows the balance to go down to -$10" do
      start_balance = 100.0
      check_1 = 110.0
      account = Bank::CheckingAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      account.withdraw_using_check(check_1)
      expected_balance = start_balance - check_1

      account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go below -$10" do
      start_balance = 100.0
      check_1 = 120.0
      account = Bank::CheckingAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      proc {
        account.withdraw_using_check(check_1)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      start_balance = 100.0
      check_1 = 120.0
      account = Bank::CheckingAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.withdraw_using_check(check_1)

      # Both the value returned and the balance in the account
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      check_1 = -25.0
      account = Bank::CheckingAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      proc {
        account.withdraw_using_check(check_1)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      start_balance = 100.0
      check_1 = 10.0
      check_2 = 15.0
      check_3 = 20.0
      account = Bank::CheckingAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      account.withdraw_using_check(check_1)
      account.withdraw_using_check(check_2)
      account.withdraw_using_check(check_3)

      expected_balance = start_balance - check_1 - check_2 - check_3

      account.balance.must_equal expected_balance
    end

    it "Applies a $2 fee after the third use" do
      start_balance = 100.0
      check_1 = 10.0
      check_2 = 15.0
      check_3 = 20.0
      check_4 = 10.0
      fee_for_check_4 = 2.0
      account = Bank::CheckingAccount.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      account.withdraw_using_check(check_1)
      account.withdraw_using_check(check_2)
      account.withdraw_using_check(check_3)
      account.withdraw_using_check(check_4)

      expected_balance = start_balance - check_1 - check_2 - check_3 - check_4 - fee_for_check_4

      account.balance.must_equal expected_balance
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      account = Bank::CheckingAccount.new(1337, 150.0, "1999-03-27 11:30:09 -0800")

      proc {
        account.reset_checks
      }.must_be_silent
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      no_checks = 0
      account = Bank::CheckingAccount.new(1337, 150.0, "1999-03-27 11:30:09 -0800")
      @check_count = 2
      account.reset_checks.must_equal no_checks

    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      no_checks = 0
      account = Bank::CheckingAccount.new(1337, 150.0, "1999-03-27 11:30:09 -0800")
      @check_count = 4
      account.reset_checks.must_equal no_checks
    end
  end
end
