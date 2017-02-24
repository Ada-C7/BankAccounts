require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/money_market_account'

describe "Bank::MoneyMarketAccount" do

  describe "#initialize" do
    #Check that MoneyMarketAccount is a kind of account
    it "Check Initialize" do
      account = Bank::MoneyMarketAccount.new(123, 10000.00, "5/5/5")
      account.must_be_kind_of Bank::Account
    end

    it "Initial balance must be > 10k" do
    #initial balance cannot be less than 10,000.  This will raise an ArgumentError
      proc { Bank::MoneyMarketAccount.new(1337, 9999) }.must_raise ArgumentError
    end

  end

  describe "transactions" do
    before do
      @my_money_market = Bank::MoneyMarketAccount.new(1234, 1000000.00)
    end

    it "Does not allow more than six withdrawals" do
      #Maximum of 6 transactions allowed per month
      6.times do
        @my_money_market.withdraw(10)
      end

      #7th transaction should raise error
      proc { @my_money_market.withdraw(10) }.must_raise ArgumentError
    end

    it "Does not allow more than six deposits" do
      #Maximum of 6 transactions allowed per month
      6.times do
        @my_money_market.deposit(10)
      end

      #7th transaction should raise error
      proc { @my_money_market.deposit(10) }.must_raise ArgumentError
    end

    it "Does not allow more than six mixed deposits and withdrawals together" do
      #Maximum of 6 transactions allowed per month
      3.times do
        @my_money_market.deposit(10)
      end

      3.times do
        @my_money_market.withdraw(10)
      end

      #7th transaction should raise error
      proc { @my_money_market.deposit(10) }.must_raise ArgumentError
    end

  end

  describe "transactions" do
    before do
      @my_money_market = Bank::MoneyMarketAccount.new(1234, 10000.00)
    end

    it "if withdrawal takes balance below 10k, charges a fee of $100" do
      @my_money_market.withdraw(500)

      @my_money_market.balance.must_equal(9400)
    end

    it "if withdrawal goes below 10k, no more transactions are allowed" do
      @my_money_market.withdraw(500)

      proc { @my_money_market.withdraw(500) }.must_raise ArgumentError
    end

  end

end




#Withdrawal logic

#If a withdrawal goes below 10k a fee of $100 is imposed and no more transactions are allowed until the balance is increased using a deposit transaction.
# inputs are withdrawals, withdrawawl_ammount
# Outputs are updated balance, a fee to charge against updated balance, a warning.  A stop on withdrawals until a deposit is made that brings the balance over 10k, updated transaction number

#Each transaction will be counted against the maximum number of transactions.
# inputs are withdrawals and ammount.
# Outputs are updated balance and updated number of total transactions.

#Deposit logic
# Each transaction will be counted against the maximum number of transactions.
# inputs are withdrawal or deposit and ammount.
# output is updated total transactions
# Exception to the above: A deposit performed to reach or exceed the minimum balance of $10,000 is not counted as part of the 6 transactions.
# input are whether or not balance is below 10k, withdrawal or deposit, amount.
# outputs are updated balance, number of transactions NOT updated.

# Reset transactions - same as with check withdrawal.
# inputs are just calling the method.
# Output is the transaction total being reset to zero.

# Add interest same as to SavingsAccount
# Inputs are interest rate, balance
# Outputs are updated balance, returning interest earned.
