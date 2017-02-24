require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
# require_relative '../lib/savings_account'
require_relative '../lib/savings_account'

describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do

      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Returns a ArgumentError if initial balance is less than 10" do
      proc { balance < 10  }.must_raise ArgumentError
    end
  end

  xdescribe "#withdraw" do
    it "Applies a $2 fee each time" do
      # TODO: Your test code here!
    end
  #
  #   it "Outputs a warning if the balance would go below $10" do
  #     # TODO: Your test code here!
  #   end
  #
  #   it "Doesn't modify the balance if it would go below $10" do
  #     # TODO: Your test code here!
  #   end
  #
  #   it "Doesn't modify the balance if the fee would put it below $10" do
  #     # TODO: Your test code here!
  #   end
  # end
  #
  # describe "#add_interest" do
  #   it "Returns the interest calculated" do
  #     # TODO: Your test code here!
  #   end
  #
  #   it "Updates the balance with calculated interest" do
  #     # TODO: Your test code here!
  #   end
  #
  #   it "Requires a positive rate" do
  #     # TODO: Your test code here!
  #   end
  end
end
