require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'minitest/pride'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

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
      # skip
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance) #, "1999-03-27 11:30:09 -0800")

      account.withdraw(withdrawal_amount)

      expected_balance = (start_balance - (withdrawal_amount + 1))
      account.balance.must_equal expected_balance
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      account.withdraw_using_check(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Allows the balance to go down to -$10" do
      # skip
      account = Bank::CheckingAccount.new(1337, 100.0)  #, "1999-03-27 11:30:09 -0800")
      updated_balance = account.withdraw_using_check(110)
      updated_balance.must_equal -10
      account.balance.must_equal -10
    end

    it "Outputs a warning if the account would go below -$10" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      proc {
        account.withdraw_using_check(withdrawal_amount)
      }.must_output /.+/

    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdrawal_amount)

      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Requires a positive withdrawal amount" do
      # skip
      start_balance = 100.0
      withdrawal_amount = -25.0
      account = Bank::CheckingAccount.new(1337, start_balance)  #, "1999-03-27 11:30:09 -0800")

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(withdrawal_amount)

      updated_balance.must_equal 75
      account.balance.must_equal 75
    end

    it "Applies a $2 fee after the third use" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 10.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      4.times do
        account.withdraw_using_check(withdrawal_amount)
      end

      account.balance.must_equal 58
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 10.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      account.reset_checks
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 10.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      account.withdraw_using_check(withdrawal_amount)
      account.reset_checks
      3.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.balance.must_equal 60
    end


    it "Makes the next three checks free if more than 3 checks had been used" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 10.0
      account = Bank::CheckingAccount.new(1337, start_balance)
      3.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.reset_checks
      3.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.balance.must_equal 40
    end
  end
end
