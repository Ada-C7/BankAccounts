require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/checking'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do
  before do
    @account = Bank::CheckingAccount.new({id: 12345, balance: 100.0})
  end

  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do

      @account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      @account.withdraw(20).must_equal 79
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      @account.withdraw(110).must_equal 100
    end
  end

  describe "#check_withdraw" do
    before do
      @account = Bank::CheckingAccount.new({balance: 100})
    end

    it "Reduces the balance" do
    @account.check_withdraw(20).must_be :<, 100
    end

    it "Returns the modified balance" do 
      @account.check_withdraw(50).must_equal 50
    end

    it "Allows the balance to go down to -$10" do skip
      # TODO: Your test code here!
    end

    it "Outputs a warning if the account would go below -$10" do skip
      # TODO: Your test code here!
    end

    it "Doesn't modify the balance if the account would go below -$10" do skip
      # TODO: Your test code here!
    end

    it "Requires a positive withdrawal amount" do skip
      # TODO: Your test code here!
    end

    it "Allows 3 free uses" do skip
      # TODO: Your test code here!
    end

    it "Applies a $2 fee after the third use" do skip
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
