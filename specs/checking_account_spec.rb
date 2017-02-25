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
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 100.0)
      updated_balance = account.withdraw(25.0)

      updated_balance.must_equal 74.0
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 100.0)
      updated_balance = account.withdraw(101.0)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal 100.0
      account.balance.must_equal 100.0
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 100.0)
      updated_balance = account.withdraw_using_check(25.0)

      updated_balance.must_equal 75.0
    end

    it "Returns the modified balance" do
      # skip
      # TODO: Your test code here!
      start_balance = 100.0
      check_amount = 20.0
      account = Bank::CheckingAccount.new(1337, start_balance)

      updated_balance = account.withdraw_using_check(check_amount)

      updated_balance.must_equal 80.0
    end

    it "Allows the balance to go do down to -$10" do
      # skip
      # TODO: Your test code here!
      #check_and_fee = check_amount + fee
      account = Bank::CheckingAccount.new(1337, 100.0)

      updated_balance = account.withdraw_using_check(108)

      updated_balance.must_equal (-8)

    end

    it "Outputs a warning if the account would go below -$10" do
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 100.0)

      proc {account.withdraw_using_check(111.0)}.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 100.0)

      updated_balance = account.withdraw_using_check(111.0)

      updated_balance.must_equal 100.0
      account.balance.must_equal 100.0
    end

    it "Requires a positive withdrawal amount" do
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 100.0)

      proc {
        account.withdraw_using_check(-25.0)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      # skip
      # TODO: Your test code here!

      account = Bank::CheckingAccount.new(1337, 100.0)
      #updated_balance = account.withdraw_using_check(10.0)

      3.times do
        account.withdraw_using_check(10.0)
      end
      account.balance.must_equal 70.0

    end

    it "Applies a $2 fee after the third use" do
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 100.0)

      4.times do
        account.withdraw_using_check(10.0)
      end
      account.balance.must_equal 58.0

    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 100.0)

      account.reset_checks.must_equal 0

    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 100.0)
      2.times do
        account.withdraw_using_check(10.0)
      end
      account.check_counter.must_equal 2
      account.balance.must_equal 80.0

      account.reset_checks
      account.reset_checks.must_equal 0

      3.times do
        account.withdraw_using_check(10.0)
      end
      account.check_counter.must_equal 3
      account.balance.must_equal 50.0

    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # skip
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(1337, 200.0)
      5.times do
        account.withdraw_using_check(10.0)
      end
      account.check_counter.must_equal 5
      account.balance.must_equal 146.0

      account.reset_checks
      account.reset_checks.must_equal 0

      4.times do
        account.withdraw_using_check(10.0)
      end
      account.check_counter.must_equal 4
      account.balance.must_equal 104.0
    end
  end
end
