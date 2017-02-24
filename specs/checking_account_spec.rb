require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do
  before do
  @account = Bank::CheckingAccount.new(12345, 100.0)
  end

  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      @account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      # TODO: Your test code here!
      @account.withdraw(10.0)
      @account.balance.must_equal 89.0
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      # TODO: Your test code here!
      start_balance = 100.0
      updated_balance = @account.withdraw(100.0)

      updated_balance.must_equal start_balance
      @account.balance.must_equal start_balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      # TODO: Your test code here!
      @account.withdraw_using_check(10.0)
      @account.balance.must_equal 90.0
    end

    it "Returns the modified balance" do
      # TODO: Your test code here!
      @account.withdraw_using_check(20.0).must_equal 80
    end

    it "Allows the balance to go down to -$10" do
      # TODO: Your test code here!
      @account.withdraw_using_check(110.0)
    end

    it "Outputs a warning if the account would go below -$10" do
      # TODO: Your test code here!
      proc {
        @account.withdraw_using_check(111.0)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # TODO: Your test code here!
      start_balance = 100.0
      updated_balance = @account.withdraw_using_check(200.0)

      updated_balance.must_equal start_balance
      @account.balance.must_equal start_balance
    end

    it "Requires a positive withdrawal amount" do
      # TODO: Your test code here!
      proc {
        @account.withdraw_using_check(-10)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      # TODO: Your test code here!
      3.times { @account.withdraw_using_check(10.0) }

      @account.balance.must_equal 70.0
    end

    it "Applies a $2 fee after the third use" do
      # TODO: Your test code here!
      4.times { @account.withdraw_using_check(10.0) }

      @account.balance.must_equal 58.0
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      # TODO: Your test code here!
      @account.reset_checks
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # TODO: Your test code here!
      2.times { @account.withdraw_using_check(10) }
      @account.reset_checks if @account.used_checks < 3
      3.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal 50
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # TODO: Your test code here!
      4.times { @account.withdraw_using_check(10) }
      @account.reset_checks if @account.used_checks > 3
      3.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal 28
    end
  end
end
