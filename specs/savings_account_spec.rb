require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
# require_relative '../lib/savings_account'
require_relative '../lib/savings_account'
# require_relative '..lib/account'

describe "SavingsAccount" do
  describe "#initialize" do

    it "Is a kind of Account" do

      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Returns a ArgumentError if initial balance is less than 10" do
      account = Bank::SavingsAccount.new(1213, 3)
      proc { if @balance < 10
      end  }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      amount.must_equal @balance - amount - 2
    end
    #
    it "Outputs a warning if the balance would go below $10" do
      proc {
        Bank::Account.new(1337, 5)
      }.must_raise ArgumentError
    end

    it "Doesn't modify the balance if it would go below $10" do
      Bank::SavingsAccount.new(id, balance)
      if @balance < 10
        return @balance
      end
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      if @balance - amount -2 < 10
        return @balancest
      end
    end
    #
    describe "#add_interest" do
      it "Returns the interest calculated" do
        interest.must_equal @balance * (rate/100)
      end

      it "Updates the balance with calculated interest" do
        rate = @balance * (rate/100)
        @balance.must_equal @balance + rate
      end

      it "Requires a positive rate" do
        rate = @balance * (rate/100)
        rate.must_be :>, 0
      end
    end
  end
end 
