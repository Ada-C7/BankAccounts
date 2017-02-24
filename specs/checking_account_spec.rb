require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
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
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      # TODO: Your test code here!
      Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(100).must_equal 9800
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      # TODO: Your test code here!
      proc {
        Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(10100)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the fee would put it below $0.00" do
      # TODO: Your test code here!
        Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(100000).must_equal 10000
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      # TODO: Your test code here!
      account =Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.withdraw_using_check(1000)
      account.balance.must_equal 8900
    end

    it "Returns the modified balance" do
      # TODO: Your test code here!
      Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw_using_check(100).must_equal 9800
    end

    it "Allows the balance to go down to -$10" do
      # TODO: Your test code here!
      Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw_using_check(10900).must_equal (-1000)
    end

    it "Outputs a warning if the account would go below -$10" do
      # TODO: Your test code here!
      proc {
        Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw_using_check(11000)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.withdraw_using_check(11000)
      account.balance.must_equal (10000)
    end

    it "Requires a positive withdrawal amount" do
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      proc {
        account.withdraw_using_check(-1000)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      3.times do
        account.withdraw_using_check(1000)
      end
      account.balance.must_equal (6700)
    end

    it "Applies a $2 fee after the third use" do
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      4.times do
        account.withdraw_using_check(1000)
      end
      account.balance.must_equal (5400)
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      3.times do
        account.withdraw_using_check(1000)
      end
      account.new_month = true
      account.reset_checks
      account.withdraw_using_check(1000)
      account.balance.must_equal (5600)
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.withdraw_using_check(1000)
      account.new_month = true
      account.reset_checks
      account.withdraw_using_check(1000)
      account.balance.must_equal (7800)
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      5.times do
        account.withdraw_using_check(1000)
      end
      account.new_month = true
      account.reset_checks
      account.num_checks_used.must_equal 0
      # account.withdraw_using_check(1000)
      # account.balance.must_equal (3000)
    end
  end
end
