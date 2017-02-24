require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'

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
      account = Bank::CheckingAccount.new(12345, 100.0, 20170101, 3)
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do

    before do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      @account = Bank::CheckingAccount.new(id, starting_balance,open_date, 3)
    end

    it "Applies a $1 fee each time" do
      @account.withdraw(10).must_equal 89
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      @account.withdraw(99).must_equal 100
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 3)

      account.withdraw_using_check(10).must_be :<, 100

    end

    it "Returns the modified balance" do

      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 3)

      account.withdraw_using_check(10).must_equal 90
    end

    it "Allows the balance to go down to -$10" do

      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 3)

      account.withdraw_using_check(110).must_equal (-10)

    end

    it "Outputs a warning if the account would go below -$10" do

      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 0)

      proc {
        account.withdraw_using_check(110)
      }.must_output /.+/

    end

    it "Doesn't modify the balance if the account would go below -$10" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 0)

      account.withdraw_using_check(111).must_equal 100

    end

    it "Requires a positive withdrawal amount" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 3)

      # TODO: Your test code here!
      proc {
        account.withdraw_using_check(-10)
      }.must_raise ArgumentError

    end

    it "Allows 3 free uses" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 3)

      account.withdraw_using_check(2).must_equal 98
    end

    it "Applies a $2 fee after the third use" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 0)

      account.withdraw_using_check(2).must_equal 96
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 0)

      account.reset_checks.must_equal 3
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 3)
      2.times do account.withdraw_using_check(10) # this decreases balance by 20
        #returned balance should be 80
      end
      account.reset_checks
      account.withdraw_using_check(10).must_equal 70
    end
  

    it "Makes the next three checks free if more than 3 checks had been used" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      account = Bank::CheckingAccount.new(id, starting_balance,open_date, 3)

      3.times do account.withdraw_using_check(10)
      end

      account.reset_checks
      account.withdraw_using_check(10).must_equal 60
    end
  end
end
