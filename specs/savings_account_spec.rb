require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/savings'

# Here we'll only test things that are different.

describe "SavingsAccount" do

  before do
      @account = Bank::SavingsAccount.new(12345, 100.0, "Jan 1, 2017")
  end

  describe "#initialize" do
    it "Is a kind of Account" do
      @account.must_be_kind_of Bank::Account
    end

    it "Raises an error if initial balance is less than $10" do
      proc {
        Bank::SavingsAccount.find(12345, 5, "Jan 1, 2017")
        }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      @account.withdraw(50)
      @account.balance.must_equal 48.0
    end

    it "Outputs a warning if the balance would go below $10" do
      proc {
        @account.withdraw(150)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if it would go below $10" do
      starting_balance = @account.balance
      updated_balance = @account.withdraw(150)
      updated_balance.must_equal starting_balance
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      starting_balance = @account.balance
      updated_balance = @account.withdraw(90)
      updated_balance.must_equal starting_balance
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
