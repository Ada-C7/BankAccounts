require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'

describe "CheckingAccount" do
  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.must_be_kind_of Bank::Account
      account.must_respond_to :num_checks_used
      account.num_checks_used.must_equal 0
      account.must_respond_to :new_month
      account.new_month.must_equal false
    end

    # Checks for instance variables
    it "Initial value for instance variable are set" do
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.must_respond_to :num_checks_used
      account.num_checks_used.must_equal 0
      account.must_respond_to :new_month
      account.new_month.must_equal false
    end
  end

  # Decreases balance in decreased by the withdrawal amount, including $1 fee
  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(100).must_equal 9800
    end

    # Balance does not change, returns amount
    it "Doesn't modify the balance if the fee would put it negative" do
      proc {
        Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(10100)
      }.must_output (/.+/)
    end

    # Balance does not change, returns amount
    it "Doesn't modify the balance if the fee would put it below $0.00" do
      Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw(100000).must_equal 10000
    end
  end

  describe "#withdraw_using_check" do
    # Withdraw the amount entered, if theres no conflict
    it "Reduces the balance" do
      account =Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.withdraw_using_check(1000)
      account.balance.must_equal 8900
    end

    # Checks that the method returns the updated balance
    it "Returns the modified balance" do
      Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw_using_check(100).must_equal 9800
    end

    # Checks that user can overdraft upto -$10.00, when using withdraw_using_check
    it "Allows the balance to go down to -$10" do
      Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw_using_check(10900).must_equal (-1000)
    end

    # Outputs an error message when the account will be overdraft by more than $10.00
    it "Outputs a warning if the account would go below -$10" do
      proc {
        Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800").withdraw_using_check(11000)
      }.must_output (/.+/)
    end

    # Checks that the method returns an unchanged balance.
    it "Doesn't modify the balance if the account would go below -$10" do
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.withdraw_using_check(11000)
      account.balance.must_equal (10000)
    end

    # Checks that a negative check amount will raise an error.
    it "Requires a positive withdrawal amount" do
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      proc {
        account.withdraw_using_check(-1000)
      }.must_raise ArgumentError
    end

    # Account owner gets 3 free checks per month
    it "Allows 3 free uses" do
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      3.times do
        account.withdraw_using_check(1000)
      end
      account.balance.must_equal (6700)
    end

    # Account owner is charged $2.00 fee for
    it "Applies a $2 fee after the third check" do
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      4.times do
        account.withdraw_using_check(1000)
      end
      account.balance.must_equal (5400)
    end
  end

  describe "#reset_checks" do
    # Calls the method without error
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

    # Resets used check count to 0
    it "Makes the next three checks free if less than 3 checks had been used" do
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      account.withdraw_using_check(1000)
      account.new_month = true
      account.reset_checks
      account.withdraw_using_check(1000)
      account.balance.must_equal (7800)
    end

    # Resets used check count to 0
    it "Makes the next three checks free if more than 3 checks had been used" do
      # TODO: Your test code here!
      account = Bank::CheckingAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      5.times do
        account.withdraw_using_check(1000)
      end
      account.new_month = true
      account.reset_checks
      account.num_checks_used.must_equal 0
    end
  end
end
