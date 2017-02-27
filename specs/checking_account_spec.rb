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
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.withdraw(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount - 1
      account.balance.must_equal expected_balance
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      start_balance = 100.0
      withdrawal_amount = 100.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdraw_using_check_amount = 50.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.withdraw_using_check(withdraw_using_check_amount)

      expected_balance = start_balance - withdraw_using_check_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdraw_using_check_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdraw_using_check_amount)

      expected_balance = start_balance - withdraw_using_check_amount
      updated_balance.must_equal expected_balance
    end

    it "Allows the balance to go down to -$10" do
      start_balance = 100.0
      withdraw_using_check_amount = 109.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdraw_using_check_amount)

      expected_balance = start_balance - withdraw_using_check_amount
      updated_balance.must_be :>, -11
    end

    it "Outputs a warning if the account would go below -$10" do
      start_balance = 100.0
      withdraw_using_check_amount = 111.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      proc {
        account.withdraw_using_check(withdraw_using_check_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      start_balance = 100.0
      withdraw_using_check_amount = 111.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdraw_using_check_amount)

      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdraw_using_check_amount = -25.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      proc {
        account.withdraw_using_check(withdraw_using_check_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      start_balance = 100.0
      withdraw_using_check_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.counter = 3

      updated_balance = account.withdraw_using_check(withdraw_using_check_amount)
      expected_balance = start_balance - withdraw_using_check_amount
      updated_balance.must_equal expected_balance
    end

    it "Applies a $2 fee after the third use" do
      start_balance = 100.0
      withdraw_using_check_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.counter = 4

      updated_balance = account.withdraw_using_check(withdraw_using_check_amount)
      expected_balance = start_balance - withdraw_using_check_amount - 2
      updated_balance.must_equal expected_balance
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      start_balance = 100.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.must_respond_to :reset_checks
    end

    it "Resets the counter to 3 if less than 3 checks had been used" do
      start_balance = 100.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      account.counter = 2

      account.reset_checks

      account.counter.must_equal 0
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      start_balance = 100.0
      withdraw_using_check_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      account.counter = 2

      account.reset_checks
      updated_balance = account.withdraw_using_check(withdraw_using_check_amount)
      expected_balance = start_balance - withdraw_using_check_amount
      updated_balance.must_equal expected_balance
    end

    it "Resets the counter to 3 if more than 3 checks had been used" do
      start_balance = 100.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      account.counter = 4

      account.reset_checks

      account.counter.must_equal 0
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      start_balance = 100.0
      withdraw_using_check_amount = 25.0 
      account = Bank::CheckingAccount.new(1337, start_balance)
      account.counter = 4

      account.reset_checks
      updated_balance = account.withdraw_using_check(withdraw_using_check_amount)
      expected_balance = start_balance - withdraw_using_check_amount
      updated_balance.must_equal expected_balance
    end
  end
end
