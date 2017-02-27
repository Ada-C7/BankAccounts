require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

describe "CheckingAccount" do
  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0, "date")
      account.must_be_kind_of Bank::Account, "This is not an account."
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      start_balance = 100.0
      amount = 50.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      updated_balance = account.withdraw(amount)

      updated_balance.must_equal 49, "$1 fee was not applied."
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      start_balance = 100.0
      amount = 100.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      account.withdraw(amount)
      account.balance.must_equal start_balance, "Balance was modified even though it resulted in a negative balance."
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      start_balance = 100.0
      amount = 50.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      account.withdraw_using_check(amount)
      account.balance.must_be :<, start_balance, "Balance was not reduced."
    end

    it "Returns the modified balance" do
      start_balance = 200.0
      amount = 40.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      updated_balance = account.withdraw_using_check(amount)

      expected_balance = start_balance - amount
      updated_balance.must_equal expected_balance, "Modified balance was not returned."
    end

    it "Allows the balance to go down to -$10" do
      account = Bank::CheckingAccount.new(1337, 100.0, "date")
      account.withdraw_using_check(account.balance + 10)
      account.balance.must_equal (-10), "Balance was not allowed to go down to -$10."
    end

    it "Outputs a warning if the account would go below -$10" do
      start_balance = 100.0
      amount = 120.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")
      proc {
        account.withdraw_using_check(amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      start_balance = 100.0
      amount = 111.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      account.withdraw_using_check(amount)
      account.balance.must_equal start_balance, "Balance was modified inspite of the fact that it resulted in a balance less than -10."
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -25.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      start_balance = 100.0
      amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      3.times do
        account.withdraw_using_check(amount)
      end

      account.balance.must_equal (start_balance - (amount * 3)), "A fee is wrongly being charged on the first 3 checks of the month."
    end

    it "Applies a $2 fee after the third use" do
      start_balance = 500.0
      amount = 50.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      4.times do
        account.withdraw_using_check(amount)
      end

      account.balance.must_equal (start_balance - ((amount * 4) + 2)), "A fee has not been charged for the 4th check of the month."
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      start_balance = 500.0
      amount = 50.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      2.times do
        account.withdraw_using_check(amount)
      end

      account.reset_checks
      account.check_count.must_equal 0, "calling reset-check method resulted in an error."
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      start_balance = 500.0
      amount = 50.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      1.times do
        account.withdraw_using_check(amount)
      end
      account.reset_checks
      3.times do
        account.withdraw_using_check(amount)
      end

      account.balance.must_equal start_balance - (amount * 4), "Check count was not reset when less than 3 checks had been used."
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      start_balance = 500.0
      amount = 50.0
      account = Bank::CheckingAccount.new(1337, start_balance, "date")

      5.times do
        account.withdraw_using_check(amount)
      end
      account.reset_checks
      2.times do
        account.withdraw_using_check(amount)
      end
      account.balance.must_equal start_balance - (amount * 7 + 4), "Check count was not reset when more than 3 checks had been used."
    end
  end
end
