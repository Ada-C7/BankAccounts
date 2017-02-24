require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'
require_relative '../lib/account'

# TODO: uncomment the next line once you start wave 3 and add


#
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
      checking_account = Bank::CheckingAccount.new(11, 200)
      new_balance = checking_account.withdraw(10)
      new_balance.must_equal 189
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      # skip
      checking_account = Bank::CheckingAccount.new(11, 200)
      proc { checking_account.withdraw(200)}.must_output(/.+/)
      checking_account.balance.must_equal 200
    end
  end

  describe "#withdraw_using_check" do
    # skip
    it "Reduces the balance" do
      # TODO: Your test code here!
      checking_account = Bank::CheckingAccount.new(11, 200)
      checking_account.balance.must_equal 200
      checking_account.withdraw_with_check(10)
      checking_account.balance.must_equal 190
    end

    it "Returns the modified balance" do
      # skip
      # TODO: Your test code here!
      checking_account = Bank::CheckingAccount.new(11, 200)
      checking_account.balance.must_equal 200
      checking_account.withdraw_with_check(10)
      checking_account.balance.must_equal 190
    end

    it "Allows the balance to go down to -$10" do
      # skip
      # TODO: Your test code here!
      checking_account = Bank::CheckingAccount.new(11, 200)
      checking_account.withdraw_with_check(210)
      checking_account.balance.must_equal(-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      # skip
      # TODO: Your test code here!
      checking_account = Bank::CheckingAccount.new(11, 200)
      checking_account.withdraw_with_check(211)
      checking_account.balance.must_equal 200
      proc { checking_account.withdraw_with_check(211)}.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # skip
      # TODO: Your test code here!
      checking_account = Bank::CheckingAccount.new(11, 200)
      checking_account.withdraw_with_check(211)
      checking_account.balance.must_equal 200
    end

    it "Requires a positive withdrawal amount" do
      # skip
      # TODO: Your test code here!
      start_balance = 100.0
      withdrawal_amount = -25.0
      checking_account = Bank::CheckingAccount.new(11, start_balance)
      proc {
        checking_account.withdraw_with_check(withdrawal_amount)
      }.must_raise(ArgumentError)
    end

    it "Allows 3 free uses" do
      # skip
      # TODO: Your test code here!
    end

    it "Applies a $2 fee after the third use" do
      # skip
      # TODO: Your test code here!
    end
  end

  describe "#reset_checks" do
    # skip
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
