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
      account = Bank::MoneyMarketAccount.new(1,10000)
      account.must_be_kind_of Bank::Account
    end

    it "Raises error if initial balance < 10,000" do
      # account = Bank::MoneyMarketAccount.new(1,9999)
      proc {Bank::MoneyMarketAccount.new(1,9999)}.must_raise ArgumentError
    end

    # it "maximum of 6 transactions per month - output message and do not perform transaction unless it's rectifying an overdrawn account" do
    # end

  end

  describe "#withdraw updates" do

    it "if withdrawal transaction brings balance to below 10000, impose $100 fee" do
      account = Bank::MoneyMarketAccount.new(1,10000)
      account.withdraw(1)
      account.balance.must_equal 9899
      account.too_low.must_be :==, true
    end

    it "if too_low is true, return message and don't allow transaction" do
      # skip
      account = Bank::MoneyMarketAccount.new(1,10500)
      account.balance.must_equal 10500
      account.too_low.must_be :==, false
      account.withdraw(501)
      account.balance.must_equal 9899
      account.too_low.must_equal true
      proc {account.withdraw(1)}.must_output(/.+/)

    end

    it "if transactions >= 6 cannot withdraw" do
      account = Bank::MoneyMarketAccount.new(1,10500)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.transactions.must_equal 5
      account.withdraw(10)
      account.transactions.must_equal 6
      account.deposit(1)
      account.max_trans_reached.must_equal true
    end

    it "a withdrawal increases the number of transactions" do
      account = Bank::MoneyMarketAccount.new(1,10500)
      account.transactions.must_equal 0
      account.withdraw(10)
      account.transactions.must_equal 1
    end
  end

  describe "#deposit updates" do
    it "if balance is below 10000, cannot deposit unless amount_deposited + balance >= 10000" do
      account = Bank::MoneyMarketAccount.new(1,10500)
      account.withdraw(501)
      account.too_low.must_equal true
      account.balance.must_equal 9899
      account.deposit(1)
      account.balance.must_equal 9899
      account.deposit(101)
      account.balance.must_equal 10000
    end


    it "if transactions >= 6 cannot deposit" do
      # skip
      account = Bank::MoneyMarketAccount.new(1,10500)
      account.deposit(1)
      account.deposit(1)
      account.deposit(1)
      account.deposit(1)
      account.deposit(1)
      account.deposit(1)
      account.balance.must_equal 10506
      account.deposit(1)
      account.balance.must_equal 10506
      account.max_trans_reached.must_equal true

    end

    it "if balance is below 10000 and it is a deposit that brings the account back to 10000, it doesn't count toward transactions" do
      account = Bank::MoneyMarketAccount.new(1,10500)
      account.transactions.must_equal 0
      account.withdraw(501)
      account.transactions.must_equal 1
      account.too_low.must_equal true
      account.balance.must_equal 9899
      account.deposit(1)
      account.transactions.must_equal 1
      account.deposit(101)
      account.transactions.must_equal 1
      account.balance.must_equal 10000
    end

    it "after fixing a too_low, transactions continue to increment" do
      account = Bank::MoneyMarketAccount.new(1,10500)
      account.transactions.must_equal 0
      account.withdraw(501) #overdrawn
      account.transactions.must_equal 1
      account.too_low.must_equal true
      account.deposit(1) #doesn't count
      account.transactions.must_equal 1
      account.too_low.must_equal true
      account.deposit(101) #not overdrawn
      account.too_low.must_equal false
      account.transactions.must_equal 1 #didn't count
      account.balance.must_equal 10000
      account.deposit(100) #not overdrawn
      account.too_low.must_equal false
      account.transactions.must_equal 2 #counted

    end

    it "if max_trans_reached a deposit fixing too_low will be permitted" do
      # skip
      account = Bank::MoneyMarketAccount.new(1,10500)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.withdraw(10)
      account.transactions.must_equal 5
      account.withdraw(451) #overdrawn
      account.balance.must_equal 9899
      account.transactions.must_equal 6
      account.too_low.must_equal true
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      skip
      account = Bank::SavingsAccount.new(1,100)
      account.balance.must_equal 100
      account.add_interest(0.25).must_equal 0.25
    end

    it "Updates the balance with calculated interest" do
      skip
      account = Bank::SavingsAccount.new(1,100)
      first_balance = account.balance
      interest_earned = account.add_interest(0.25)
      second_balance = account.balance
      second_balance.must_equal (first_balance + interest_earned)
    end

    it "Requires a positive rate" do
      skip
      account = Bank::SavingsAccount.new(1,100)
      test_rate = -0.25
      proc {account.add_interest(test_rate)}.must_output(/.+/)
    end
  end

  describe "#reset_transactions" do
    it "resets transactions to zero" do
    end

    it "can be called with no error" do
    end

  end
end
