require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  describe "#initialize" do

    before do
      @account = Bank::SavingsAccount.new(12345, 100.0)
    end

    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      @account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      # TODO: Your test code here!
      @account.balance.must_be :>=, 10.0

      proc {
        Bank::SavingsAccount.new(12345, 5.0)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    FEE = 2.00

    before do

      @balance = 100.0
      @account = Bank::SavingsAccount.new(12345, @balance)
      #@withdraw = @account.withdraw(@withdraw_amount)
    end

    it "Applies a $2 fee each time" do
      # TODO: Your test code here!
      withdraw_amount = 25.0
      expected_balance = @balance - withdraw_amount - FEE
      @account.withdraw(withdraw_amount)
      @account.balance.must_equal expected_balance
    end

    # Does not allow the account to go below the $10 minimum balance - Will output a warning message and return the original un-modified balance
    it "Outputs a warning if the balance would go below $10" do
      # TODO: Your test code here!
      withdraw_amount = 95.0
      # Another proc! This test expects something to be printed
      # to the terminal, using 'must_output'. /.+/ is a regular
      # expression matching one or more characters - as long as
      # anything at all is printed out the test will pass.
      proc {
        @account.withdraw(withdraw_amount)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if it would go below $10" do
      # TODO: Your test code here!
      withdraw_amount = 95.0

      updated_balance = @account.withdraw(withdraw_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal @balance
      @account.balance.must_equal @balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      # TODO: Your test code here!
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
