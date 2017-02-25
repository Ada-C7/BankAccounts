require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative "../lib/checking_account"


# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
# require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
#describe "CheckingAccount" do
  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345,100.0)
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      fee = 1.0
      initial_balance = 100.0
      account = Bank::CheckingAccount.new(12345, initial_balance)
      withdrawal_amount = 50.0
      new_balance = account.withdraw(withdrawal_amount)
      new_balance.must_equal (initial_balance - withdrawal_amount - fee)
    end

    it "Doesn't modify the balance if it would go negative" do
      initial_balance = 100.0
      account = Bank::CheckingAccount.new(12345, initial_balance)
      withdrawal_amount = 200.0
      new_balance = account.withdraw(withdrawal_amount)
      new_balance.must_equal initial_balance
    end
  end

  describe "#withdraw_using_check" do
    # before do
    #   @account =
    # end
    it "Reduces the balance" do
      # TODO: Your test code here!
      start_balance = 100.0
      withdrawal_amount = 25.0
      #open_date = '1/1/2017'
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.withdraw_using_check(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0

      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Allows the balance to go down to -$10" do
      start_balance = 100.0
      withdrawal_amount = 110.0
      max_overdraft = -10.0

      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdrawal_amount)

      updated_balance.must_equal max_overdraft

    end

    it "Outputs a warning if the account would go below -$10" do
      start_balance = 100.0
      withdrawal_amount = 120.0

      account = Bank::CheckingAccount.new(1337, start_balance)

      proc {account.withdraw_using_check(withdrawal_amount)}.must_output "Check ($#{withdrawal_amount}) would make your account go below -$10."
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      start_balance = 100.0
      withdrawal_amount = 120.0

      account = Bank::CheckingAccount.new(1337, start_balance)

      account.withdraw_using_check(withdrawal_amount).must_equal start_balance
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -10.0

      account = Bank::CheckingAccount.new(1337, start_balance)

      proc {account.withdraw_using_check(withdrawal_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      start_balance = 100.0
      withdrawal_amount = 10.0

      check_uses = 3
      check_fee = 0.0
      total_withdrawal = withdrawal_amount * check_uses

      account = Bank::CheckingAccount.new(1337, start_balance)

      check_uses.times do
        account.withdraw_using_check(withdrawal_amount)
      end

      account.balance.must_equal (start_balance-total_withdrawal)

    end

    it "Applies a $2 fee after the third use" do
      start_balance = 100.0
      withdrawal_amount = 10.0

      check_uses = 4
      check_fee = 2.0
      total_withdrawal = withdrawal_amount * check_uses

      account = Bank::CheckingAccount.new(1337, start_balance)

      check_uses.times do
        account.withdraw_using_check(withdrawal_amount)
      end

      account.balance.must_equal (start_balance-total_withdrawal)
    end
  end

  xdescribe "#reset_checks" do
    it "Can be called without error" do
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # TODO: Your test code here!
    end
  end
