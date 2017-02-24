require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'
# require_relative '../lib/account'
# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb



# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do

  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      # skip
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do

    it "Applies a $1 fee each time" do
      # skip
      start_balace = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(123, start_balace)

      account.withdraw(withdrawal_amount)
      expected_balance = start_balace - withdrawal_amount - 1.0
      account.balance.must_equal expected_balance
    end

    it "outputs a warning message if you will account will go negative" do
      # skip
      start_balace = 100.0
      withdrawal_amount = 100.0
      account = Bank::CheckingAccount.new(123, start_balace)
      account.withdraw(withdrawal_amount)
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    # maybe you don't need this test cause you know checking account is a account type so it should pass all account types
    it "will not change the balance if withdrawl causes negative" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))
      updated_balance = account.withdraw(withdrawal_amount)
      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end
  end


  describe "#withdraw_using_check" do

    it "Reduces the balance" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))

      account.withdraw_using_check(withdrawal_amount)
      account.balance.must_be :<, start_balance
    end

    it "Returns the modified balance" do
      # skip
      start_balance = 300.0
      withdrawal_amount = 125.0
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))

      updated_balance = account.withdraw_using_check(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Allows the balance to go down to -$10" do
      # skip
      start_balance = 90.00
      # withdrawal_amount = 100.00
      withdrawal_amount = 96.00
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))

      updated_balance = account.withdraw_using_check(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go below -$10" do
      # skip
      start_balance = 90.00
      withdrawal_amount = 125.00
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))

      account.withdraw_using_check(withdrawal_amount)
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # skip
      start_balance = 90.00
      withdrawal_amount = 125.00
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))

      account.withdraw_using_check(withdrawal_amount)
      account.balance.must_equal start_balance
    end

    # this is test is also part of the account -withdrawl method
    it "Requires a positive withdrawal amount" do
      # skip
      start_balance = 90.00
      withdrawal_amount = -125.00
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))

      proc {
        account.withdraw_using_check(withdrawal_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      # skip
      start_balance = 500.00
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))

      # account.check_count=(2)
      # account.withdraw_using_check(25.00)
      # account.balance.must_equal 475.00

      account.withdraw_using_check(25.00)
      account.check_count.must_equal 1
      account.balance.must_equal 475.00

      account.withdraw_using_check(25.00)
      account.check_count.must_equal 2
      account.balance.must_equal 450.00

      account.withdraw_using_check(25.00)
      account.check_count.must_equal 3
      account.balance.must_equal 425.00
    end

    it "Applies a $2 fee after the third use" do
      # skip

      #put a helper method here that loops and writes a bunch of checks
      def write_checks()
        start_balance = 500.00
        account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))
        test_balance = start_balance
        5.times do |count|
          account.withdraw_using_check(25.00)
          count += 1
          account.check_count.must_equal count
          if count <= 3
            test_balance -= 25.00
            account.balance.must_equal test_balance
          elsif count > 3
            test_balance -= 27.00
            account.balance.must_equal test_balance
          end
        end
      end
      write_checks

      # or can write out a bunch of methods one by one:
      # start_balance = 500.00
      # account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))

      # account.withdraw_using_check(25.00)
      # account.check_count.must_equal 1
      # account.balance.must_equal 475.00
      #
      # account.withdraw_using_check(25.00)
      # account.check_count.must_equal 2
      # account.balance.must_equal 450.00
      #
      # account.withdraw_using_check(25.00)
      # account.check_count.must_equal 3
      # account.balance.must_equal 425.00
      #
      # account.withdraw_using_check(25.00)
      # account.check_count.must_equal 4
      # account.balance.must_equal 398.00
      #
      # account.withdraw_using_check(25.00)
      # account.check_count.must_equal 5
      # account.balance.must_equal 371.00
    end
  end

  describe "#reset_checks" do
    # dont get what this test is asking for
    it "Can be called without error" do
      # skip
      start_balance = 500.00
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))
      account.must_respond_to :reset_checks
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # skip
      start_balance = 500.00
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))
      account.check_count=(2)
      account.check_count.must_equal 2
      account.reset_checks
      account.check_count.must_equal 0

      # test by calling withdraw_using_check and making sure no fee is applied
      account.withdraw_using_check(25.00)
      account.check_count.must_equal 1
      account.balance.must_equal 475.00
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # skip
      start_balance = 500.00
      account = Bank::CheckingAccount.new(1337, start_balance, DateTime.parse("1999-03-27 11:30:09"))
      account.check_count=(5)
      account.check_count.must_equal 5
      account.reset_checks
      account.check_count.must_equal 0

      account.withdraw_using_check(25.00)
      account.check_count.must_equal 1
      account.balance.must_equal 475.00
    end
  end
end
