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
      account = Bank::CheckingAccount.new(12345, 100.0)
      balance_before = account.balance
      account.withdraw(20)
      account.balance.must_equal (balance_before - 21)

    end

    it "Doesn't modify the balance if the fee would put it negative" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      balance_before = account.balance
      account.withdraw(100)
      account.balance.must_equal balance_before
    end
  end

  describe "#withdraw_using_check" do
    # before do
    #   @account = Bank::CheckingAccount.new(1714, 450.0)
    # end

    it "Reduces the balance" do
      account = Bank::CheckingAccount.new(1714, 450.0)
      balance_before = account.balance
      account.withdraw_using_check(100)
      account.balance.must_be :<, balance_before
    end

    it "Returns the modified balance" do
      account = Bank::CheckingAccount.new(1714, 450.0)
      balance_before = account.balance
      account.withdraw_using_check(100)
      account.balance.must_equal (balance_before - 100)
    end

    it "Allows the balance to go down to -$10" do
      account = Bank::CheckingAccount.new(1714, 450.0)
      account.withdraw_using_check(460)
      account.balance.must_equal (-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      account = Bank::CheckingAccount.new(1714, 450.0)
      proc {
        account.withdraw_using_check(500)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      account = Bank::CheckingAccount.new(1714, 450.0)
      balance_before = account.balance
      account.withdraw_using_check(500)
      account.balance.must_equal balance_before
    end

    it "Requires a positive withdrawal amount" do
      account = Bank::CheckingAccount.new(1714, 450.0)
      withdrawal_amount = -25.0

      proc {
        account.withdraw_using_check(withdrawal_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      account = Bank::CheckingAccount.new(1212, 300.0)
      withdrawal_amount = 10
      balance_before = account.balance
      3.times do
        account.withdraw_using_check(withdrawal_amount)
      end

      account.balance.must_equal (balance_before - (3 * withdrawal_amount))
    end

    it "Applies a $2 fee after the third use" do
      account = Bank::CheckingAccount.new(1212, 300.0)
      withdrawal_amount = 10
      balance_before = account.balance

      4.times do
        account.withdraw_using_check(withdrawal_amount)
      end

      account.balance.must_equal (balance_before - (4 * withdrawal_amount) - 2)
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      account = Bank::CheckingAccount.new(1714, 450.0)

      
        account.reset_checks

    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      account = Bank::CheckingAccount.new(1212, 300.0)
      withdrawal_amount = 10

      2.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.reset_checks
      balance_before = account.balance

      3.times do
        account.withdraw_using_check(withdrawal_amount)
      end

      account.balance.must_equal (balance_before - (3 * withdrawal_amount))
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      account = Bank::CheckingAccount.new(1212, 300.0)
      withdrawal_amount = 10

      4.times do
        account.withdraw_using_check(withdrawal_amount)
      end
      account.reset_checks
      balance_before = account.balance

      3.times do
        account.withdraw_using_check(withdrawal_amount)
      end

      account.balance.must_equal (balance_before - (3 * withdrawal_amount))
    end

  end
end
