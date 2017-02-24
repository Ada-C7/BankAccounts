require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '/Users/sai/Documents/ada/projects/BankAccounts/lib/account.rb'
require_relative '/Users/sai/Documents/ada/projects/BankAccounts/lib/checking_account.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
# require_relative '../lib/checking_account'

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
      account.withdraw(10)
      account.balance.must_equal 89
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      account = Bank::CheckingAccount.new(12345, 20)

      proc {
        account.withdraw(20)
      }.must_output /.+/

    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw_using_check 50

      account.balance.must_equal 50
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdraw_amount = 25.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      updated_balance = account.withdraw_using_check(withdraw_amount)

      expected_balance = start_balance - withdraw_amount
      updated_balance.must_equal expected_balance

    end

    it "Allows the balance to go down to -$10" do
      account = Bank::CheckingAccount.new(12345, 50)
      account.withdraw_using_check 60

      account.balance.must_equal -10
    end

    it "Outputs a warning if the account would go below -$10" do
      account = Bank::CheckingAccount.new(12345, 50)
      proc {
        account.withdraw_using_check(70)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      account = Bank::CheckingAccount.new(12345, 50)
      account.withdraw_using_check(70)

      account.balance.must_equal 50

    end

    it "Requires a positive withdrawal amount" do
      account = Bank::CheckingAccount.new(12345, 50)
      proc {
        account.withdraw_using_check(-30)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      # TODO: Your test code here!
    end

    it "Applies a $2 fee after the third use" do
      # TODO: Your test code here!
    end
  end

  xdescribe "#reset_checks" do
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
