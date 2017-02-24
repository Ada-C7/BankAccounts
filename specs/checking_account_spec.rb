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

    it "Allows the balance to go down to -$10" do
      @account.check_withdraw(110).must_equal (-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      proc { @account.check_withdraw(200) }.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      @account.check_withdraw(200).must_equal 100
    end

    it "Requires a positive withdrawal amount" do
      @account.check_withdraw(-100).must_equal 100
    end

    it "Allows 3 free uses" do
      @account.check_withdraw(20).must_equal 80
      @account.check_withdraw(20).must_equal 60
      @account.check_withdraw(20).must_equal 40
      @account.check_withdraw(20).must_equal 18

    end

    it "Applies a $2 fee after the third use" do
      @account.check_withdraw(20).must_equal 80
      @account.check_withdraw(20).must_equal 60
      @account.check_withdraw(20).must_equal 40
      @account.check_withdraw(20).must_equal 18
      @account.check_withdraw(20).must_equal (-4)
    end
  end

  describe "#reset_checks" do

    before do
      @account = Bank::CheckingAccount.new({balance: 100})
    end

    it "Can be called without error" do
      @account.reset_checks.must_equal 3
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      @account.check_withdraw(20).must_equal 80
      @account.check_withdraw(20).must_equal 60
      @account.checks.must_equal (1)
      @account.reset_checks
      @account.checks.must_equal 3
      @account.check_withdraw(20).must_equal 40
      @account.check_withdraw(20).must_equal 20
      @account.check_withdraw(20).must_equal 0
      @account.check_withdraw(8).must_equal (-10)
    end

    it "Makes the next three checks free if more than 3 checks had been used" do

      @account.check_withdraw(20).must_equal 80
      @account.check_withdraw(20).must_equal 60
      @account.check_withdraw(20).must_equal 40
      @account.check_withdraw(20).must_equal 18
      @account.checks.must_equal (-1)
      @account.reset_checks
      @account.checks.must_equal 3
      @account.deposit(102)
      @account.check_withdraw(20).must_equal 100
      @account.check_withdraw(20).must_equal 80
      @account.check_withdraw(20).must_equal 60
      @account.check_withdraw(20).must_equal 38
    end
  end
end
