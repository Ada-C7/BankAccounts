require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'


describe "CheckingAccount" do
  before do
    @account = Bank::CheckingAccount.new(id: 12345, balance: 100.0)
    @starting_balance = @account.balance
  end

  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      @account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      @account.withdraw(1).must_equal @starting_balance - 2
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      proc {
        @account.withdraw(@account.balance)
      }.must_output(/.+/)

      @account.balance.must_equal @starting_balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      @account.withdraw_using_check(20)
      @account.balance.must_be :<, @starting_balance
    end

    it "Returns the modified balance" do
      @account.withdraw_using_check(20).must_equal @starting_balance - 20
    end

    it "Allows the balance to go down to -$10" do
      @account.withdraw_using_check(@starting_balance + 10).must_equal(-10)
    end

    it "Outputs a warning & does not modify balance if it would go below -$10" do
      proc {
        @account.withdraw_using_check(@starting_balance + 15)
      }.must_output(/.+/)

      @account.balance.must_equal @starting_balance
    end

    it "Requires a positive withdrawal amount" do
      # TODO: Your test code here!
    end

    it "Allows 3 free uses" do
      3.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal @starting_balance - 30
    end

    it "Applies a $2 fee after the third use" do
      4.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal @starting_balance - 42
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      proc { @account.reset_checks }.must_be_silent
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      @account.withdraw_using_check(10)
      @account.reset_checks
      3.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal @starting_balance - 40
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      4.times { @account.withdraw_using_check(10) }
      @account.reset_checks
      3.times { @account.withdraw_using_check(10) }
      @account.balance.must_equal @starting_balance - 72
    end
  end
end
