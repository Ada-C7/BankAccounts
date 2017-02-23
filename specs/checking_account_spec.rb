require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/CheckingAccount'

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
      initial_deposit = 15
      withdrawal_amount = 1
      account = Bank::CheckingAccount.new(1,initial_deposit)
      initial_balance = account.balance
      account.withdraw(withdrawal_amount)
      final_balance = account.balance
      (initial_balance - final_balance).must_equal withdrawal_amount + 1
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      initial_deposit = 15
      withdrawal_amount = 15
      account = Bank::CheckingAccount.new(1,initial_deposit)
      initial_balance = account.balance
      account.withdraw(withdrawal_amount)
      final_balance = account.balance
      (initial_balance - final_balance).must_equal 0
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      account = Bank::CheckingAccount.new(1,30)
      account.withdraw_using_check(20)
      account.checks_used.must_equal 1
      account.balance.must_be :<, 30
    end

    it "Returns the modified balance" do
      account = Bank::CheckingAccount.new(1,30)
      account.withdraw_using_check(20)
      account.checks_used.must_equal 1
      account.balance.must_equal 10
    end

    it "Allows the balance to go down to -$10" do
      account = Bank::CheckingAccount.new(1,30)
      account.withdraw_using_check(40)
      account.checks_used.must_equal 1
      account.balance.must_equal(-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      account = Bank::CheckingAccount.new(1,30)
      proc {account.withdraw_using_check(41)}.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # TODO: Your test code here!
    end

    it "Requires a positive withdrawal amount" do
      # TODO: Your test code here!
    end

    it "Allows 3 free uses" do
      # TODO: Your test code here!
    end

    it "Applies a $2 fee after the third use" do
      # TODO: Your test code here!
    end
  end

  describe "#reset_checks" do
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
end
