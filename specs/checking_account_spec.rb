require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/checking_account.rb'


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
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(1991, start_balance)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount - 1
      account.balance.must_equal expected_balance
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      start_balance = 100.0
      withdrawal_amount = 130.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      account.withdraw(withdrawal_amount)
      account.balance.must_equal start_balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdrawal_amount = 30.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.withdraw_using_check(withdrawal_amount)
      account.balance.must_be :<, start_balance
    end

    it "Returns the modified balance" do
      start_balance = 200.0
      withdrawal_amount = 40.0

      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance, "Balance was not modified"
    end

    it "Allows the balance to go down to -$10" do
      start_balance = 100.0
      withdrawal_amount = 109.0

      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount

      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go below -$10" do
      start_balance = 100.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.balance.must_equal start_balance, "Outputs a warning if the balance would go below -$10"

    end

    it "Doesn't modify the balance if the account would go below -$10" do
      start_balance = 100.0
      withdrawal_amount = 120.0
      account = Bank::SavingsAccount.new(1337, start_balance)

      account.withdraw(withdrawal_amount)
      account.balance.must_equal start_balance
    end

    it "Requires a positive withdrawal amount" do
      account = Bank::CheckingAccount.new(1337, 100.0)

      proc {
        account.withdraw_using_check(-10)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      start_balance = 100.0
      withdrawal_amount = 10.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      new_balance = start_balance - (withdrawal_amount * 3)

      3.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.balance.must_equal new_balance
    end

    it "Applies a $2 fee after the third use" do
      start_balance = 100.0
      withdrawal_amount = 10.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      new_balance = start_balance - ((withdrawal_amount * 4) + 2)

      4.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.balance.must_equal new_balance
    end
end

  describe "#reset_checks" do
    it "Can be called without error" do
      start_balance = 100.0
      check_count = 0
      account = Bank::CheckingAccount.new(1337, start_balance)
      account.reset_checks.must_equal check_count
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      start_balance = 100.0
      withdrawal_amount = 10.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      new_balance = start_balance - ((withdrawal_amount * 4))

      1.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.reset_checks
      3.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.balance.must_equal new_balance
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      start_balance = 100.0
      withdrawal_amount = 10.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      new_balance = start_balance - ((withdrawal_amount * 7) + 4)

      5.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.reset_checks

      2.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.balance.must_equal new_balance
    end
  end
end
