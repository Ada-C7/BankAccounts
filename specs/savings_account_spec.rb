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
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(1337, 1.00)
      }.must_raise ArgumentError
    end

  end

  describe "#withdraw" do
    before do
      @my_savings = Bank::SavingsAccount.new(1234, 500.00)
    end

    it "Applies a $2 fee each time" do
      @my_savings.withdraw(10)
      @my_savings.balance.must_equal(488.00)

      @my_savings.withdraw(10)
      @my_savings.balance.must_equal(476.00)
    end

    it "Outputs a warning if the balance would go below $10" do
      proc { @my_savings.withdraw(600) }.must_output(/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      updated_balance = @my_savings.withdraw(600.00)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal 500
      @my_savings.balance.must_equal 500
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      updated_balance = @my_savings.withdraw(490.00)

      #Both the value returned and balance in account
      #must be un-modified
      updated_balance.must_equal 500
      @my_savings.balance.must_equal 500
    end
  end

  describe "#add_interest" do
    before do
      @my_savings = Bank::SavingsAccount.new(1234, 500.00)
      @my_interest = @my_savings.add_interest(0.25)
    end

    it "Returns the interest calculated" do
      @my_interest.must_equal(1.25)
    end

    it "Updates the balance with calculated interest" do
      @my_savings.balance.must_equal(501.25)

    end

    it "Requires a positive rate" do
      # TODO: Your test code here!
    end
  end
end
