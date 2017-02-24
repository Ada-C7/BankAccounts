require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account.rb'

describe "SavingsAccount" do

  describe "#initialize" do

    it "Is a kind of Account" do
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc{Bank::SavingsAccount.new(12345, 5)}.must_raise ArgumentError
    end

  end

  xdescribe "#withdraw" do
    it "Applies a $2 fee each time" do
      skip
    end

    it "Outputs a warning if the balance would go below $10" do
      skip
    end

    it "Doesn't modify the balance if it would go below $10" do
      skip
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      skip
    end
  end

  xdescribe "#add_interest" do
    it "Returns the interest calculated" do
      skip
    end

    it "Updates the balance with calculated interest" do
      skip
    end

    it "Requires a positive rate" do
      skip
    end
  end
end
