require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      skip
      # TODO: Your test code here!
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      skip
      # TODO: Your test code here!
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      skip
      # TODO: Your test code here!
    end

    it "Returns the modified balance" do
      skip
      # TODO: Your test code here!
    end

    it "Allows the balance to go down to -$10" do
      skip
      # TODO: Your test code here!
    end

    it "Outputs a warning if the account would go below -$10" do
      skip
      # TODO: Your test code here!
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      skip
      # TODO: Your test code here!
    end

    it "Requires a positive withdrawal amount" do
      skip
      # TODO: Your test code here!
    end

    it "Allows 3 free uses" do
      skip
      # TODO: Your test code here!
    end

    it "Applies a $2 fee after the third use" do
      skip
      # TODO: Your test code here!
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      skip
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      skip
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      skip
      # TODO: Your test code here!
    end
  end
end
