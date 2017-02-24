require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
require_relative '../lib/MoneyMarketAccount'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "MoneyMarketAccount" do
  describe "#initialize" do
    before do
    end

    it "Is a kind of Account" do
      account = Bank::MoneyMarketAccount.new
      account.must_be_kind_of Account
    end

    it "Requires an initial balance of at least $10" do
    end
    it "Raises error if initial balance < 10" do
    end

  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
    end

    it "Outputs a warning if the balance would go below $10" do
    end

    it "Doesn't modify the balance if it would go below $10" do
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
    end

    it "Updates the balance with calculated interest" do
    end

    it "Requires a positive rate" do
    end
  end
end
