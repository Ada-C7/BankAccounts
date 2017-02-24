require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

#uncomment the next line once you start wave 3 and add lib/savings_account.rb
require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0, nil)
      account.must_be_kind_of Bank::Account
    end

    describe "Requires $10 opening balance." do
      it "Requires an initial balance of at least $10" do
        account = Bank::SavingsAccount.new(12345, 9.0, nil)
        proc { account.check_for_min_balance
        }.must_raise ArgumentError

      end
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      account = Bank::SavingsAccount.new(12345, 100.0, nil)
      account.balance.must_equal 100
      account.withdraw_fee(10)
      account.balance.must_equal 88
    end

  describe "Outputs a warning if the balance would go below $10" do
      it "Outputs a warning if the account would go negative" do
            start_balance = 100.0
            withdrawal_amount = 200.0
            account = Bank::Account.new(1337, start_balance)

            # Another proc! This test expects something to be printed
            # to the terminal, using 'must_output'. /.+/ is a regular
            # expression matching one or more characters - as long as
            # anything at all is printed out the test will pass.
            proc {
              account.withdraw(withdrawal_amount)
            }.must_output /.+/
          end
    end

describe "If balance goes below 10, don't modify" do
    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 95.00
      account = Bank::Account.new(1337, start_balance)
    end
  end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 100.0
      withdrawal_amount = 89.00
      account = Bank::SavingsAccount.new(1337, start_balance, min_balance = 10, open_date = nil)
      account.withdraw_fee(withdrawal_amount)
      account.balance.must_equal start_balance
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      # TODO: Your test code here!
    end

    it "Updates the balance with calculated interest" do
      # TODO: Your test code here!
    end

    it "Requires a positive rate" do
      # TODO: Your test code here!
    end
  end
end
