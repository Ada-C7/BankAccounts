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
      expected_balance = start_balance - (withdrawal_amount + 1)
      account.balance.must_equal expected_balance

    end

    it "Doesn't modify the balance if the fee would put it negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::CheckingAccount.new(1337, start_balance)

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
      withdrawal_amount = 50.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      updated_balance = account.withdraw_using_check(withdrawal_amount)
      boolean = updated_balance < start_balance
      boolean.must_equal true
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 50.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      updated_balance = account.withdraw_using_check(withdrawal_amount)
      updated_balance.must_equal 50
    end

    it "Allows the balance to go down to -$10" do
      start_balance = 100.0
      withdrawal_amount = 110.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      updated_balance = account.withdraw_using_check(withdrawal_amount)
      updated_balance.must_equal -10
    end

    it "Outputs a warning if the account would go below -$10" do
      start_balance = 100.0
      withdrawal_amount = 111.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      proc {
        account.withdraw_using_check(withdrawal_amount)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      start_balance = 100.0
      withdrawal_amount = 111.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      account.withdraw_using_check(withdrawal_amount).must_equal 100
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      deposit_amount = -25.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
     end
      #
  it "Allows 3 free uses" do
    start_balance = 100.0
    withdrawal_amount = 10.0
    account = Bank::CheckingAccount.new(1337, start_balance)
    updated_balance = account.withdraw_using_check(withdrawal_amount)
    updated_balance = account.withdraw_using_check(withdrawal_amount)
    updated_balance = account.withdraw_using_check(withdrawal_amount)
    updated_balance.must_equal 70.0
  end

  it "Applies a $2 fee after the third use" do
    start_balance = 100.0
    withdrawal_amount = 10.0
    account = Bank::CheckingAccount.new(1337, start_balance)
    updated_balance = account.withdraw_using_check(withdrawal_amount)
    updated_balance = account.withdraw_using_check(withdrawal_amount)
    updated_balance = account.withdraw_using_check(withdrawal_amount)
    updated_balance = account.withdraw_using_check(withdrawal_amount)
    updated_balance.must_equal 58
  end
    end
    #
    describe "#reset_checks" do
      it "Can be called without error" do
        start_balance = 100.0
        account = Bank::CheckingAccount.new(1337, start_balance)
        account.reset_checks
      end

      it "Makes the next three checks free if less than 3 checks had been used" do
        start_balance = 100.0
        withdrawal_amount = 10
        account = Bank::CheckingAccount.new(1337, start_balance)
        account.reset_checks
        updated_balance = account.withdraw_using_check(withdrawal_amount)
        updated_balance = account.withdraw_using_check(withdrawal_amount)
        updated_balance = account.withdraw_using_check(withdrawal_amount)
        updated_balance.must_equal 70
      end

      it "Makes the next three checks free if more than 3 checks had been used" do
        start_balance = 100.0
        withdrawal_amount = 10
        account = Bank::CheckingAccount.new(1337, start_balance)
        updated_balance = account.withdraw_using_check(withdrawal_amount)
        updated_balance = account.withdraw_using_check(withdrawal_amount)
        updated_balance = account.withdraw_using_check(withdrawal_amount)
        account.reset_checks
        updated_balance = account.withdraw_using_check(withdrawal_amount)
        updated_balance = account.withdraw_using_check(withdrawal_amount)
        updated_balance = account.withdraw_using_check(withdrawal_amount)
        updated_balance.must_equal 40
      end
    end
  end
