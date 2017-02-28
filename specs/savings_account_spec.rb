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
      account = Bank::SavingsAccount.new(12345, 10000, nil)
      account.must_be_kind_of Bank::Account
    end
end
    describe "Requires $10 opening balance." do

      it "Requires an initial balance of at least $10" do
        proc {  Bank::SavingsAccount.new(12345, 900, nil)
        }.must_raise ArgumentError
      end

    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      account = Bank::SavingsAccount.new(12345, 1000, nil)
      account.balance.must_equal 10000
      account.withdraw_fee(1000)
      account.balance.must_equal 8800
    end
  end

  describe "Outputs a warning if the balance would go below $10" do
    it "Outputs a warning if the account would go negative" do
      start_balance = 1000
      withdrawal_amount = 2000
      account = Bank::Account.new(1337, start_balance)
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output /.+/
    end
  end

  # Another proc! This test expects something to be printed
  # to the terminal, using 'must_output'. /.+/ is a regular
  # expression matching one or more characters - as long as
  # anything at all is printed out the test will pass.

  describe "If balance goes below 10, don't modify" do
    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 1000
      withdrawal_amount = 9500
      account = Bank::Account.new(1337, start_balance)
    end
  end
  describe "Won't modify balance if fee brings below minimum" do
    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 1000
      withdrawal_amount = 8900
      account = Bank::SavingsAccount.new(1337, start_balance, open_date = nil)
      account.withdraw_fee(withdrawal_amount)
      account.balance.must_equal start_balance
    end
  end

describe "balance + interest" do
 #  before do
 # @account = Bank::SavingsAccount.new(1337, start_balance, min_balance = 10, open_date = nil)
 #  end


  it "Updates the balance with calculated interest" do
    account = Bank::SavingsAccount.new(1337, 10000, open_date = nil)
    account.add_interest(0.25)
    account.balance.must_equal 12500

  end

  # describe "#add_interest" do
    it "Returns the interest calculated" do
      account = Bank::SavingsAccount.new(1337, 10000, open_date = nil)
      account.add_interest(0.25).must_equal 2500
    end


  it "Requires a positive rate" do
    account = Bank::SavingsAccount.new(1337, 10000, open_date = nil)
    proc {
      account.add_interest(-3.3)
    }.must_raise ArgumentError
  end
end
