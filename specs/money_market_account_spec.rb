require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/money_market_account'

describe "MoneyMarketAccount" do
  describe "#initialize" do
    # Check that a MoneyMarketAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800")
      account.must_be_kind_of Bank::Account
    end

    # Checks for instance variables
    it "Initial value for instance variable are set" do
      account = Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800")
      account.must_respond_to :num_transaction
      account.num_transaction.must_equal 0
      account.must_respond_to :new_month
      account.new_month.must_equal false
    end

    # Raises an error when attemted to initialize MoneyMarketAccount with initial balance less than $10,000
    it "Invalid initial balance" do
      proc {
        Bank::MoneyMarketAccount.new(12345, 900000, "1999-03-27 11:30:09 -0800")
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    # Raises error when an erroneous withdrawal amount is entered
    it "Requires a positive withdrawal amount" do
      account = Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800")
      proc {
        account.withdraw(-1000)
      }.must_raise ArgumentError
    end

    # Withdraw method will reduce accout balance, if there are no conflicts
    it "Reduces the balance" do
      account =Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800")
      account.withdraw(100000)
      account.balance.must_equal 890000
    end

    # If a withdrawal causes the balance to go below $10,000, a fee of $100 is imposed
    it "Applies a $100 fee when withdrawal causes the balance to go below $10,000" do
      account = Bank::MoneyMarketAccount.new(12345, 2000000, "1999-03-27 11:30:09 -0800")
      account.withdraw(1500000)
      account.balance.must_equal 490000
    end

    # If the balance is below $10,000, balance does not change
    it "Doesn't modify balance if the withdrawal causes the balance to be less than $10,000.00" do
      account = Bank::MoneyMarketAccount.new(12345, 2000000, "1999-03-27 11:30:09 -0800")
      account.withdraw(1100000)
      account.withdraw(10000).must_equal 890000
    end

    # With each withdrawal, the num_transaction count goes up by 1
    it "Each withdraw transaction will be counted against the maximum number of transactions" do
      account = Bank::MoneyMarketAccount.new(12345, 2000000, "1999-03-27 11:30:09 -0800")
      account.withdraw(1100)
      account.withdraw(1100)
      account.num_transaction.must_equal 2
    end

    # Transaction is not allowed when the num_transaction is greater than equal to 6
    it "Doesn't modify the balance if the num_transaction is greater than equal to 6" do
      account = Bank::MoneyMarketAccount.new(12345, 2000000, "1999-03-27 11:30:09 -0800")
      6.times do
        account.withdraw(0)
      end
      account.withdraw(11000).must_equal 2000000
    end
  end

  xdescribe "#deposit" do
    # Raises error when an erroneous deposit amount is entered
    it "Requires a positive deposit amount" do
      account = Bank::MoneyMarketAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
      proc {
        account.deposit(-1000)
      }.must_raise ArgumentError
    end

    # Deposit method will increase accout balance, if there are no conflicts
    it "Increase the balance" do
      account =Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800")
      account.deposit(1000)
      account.balance.must_equal 1001000
    end

    # If a deposit causes the balance to be greater than equal to $10,000, a fee of $100 is removed
    it "Removes $100 fee when deposit causes the balance to be greater than equal to $10,000" do
      account = Bank::MoneyMarketAccount.new(12345, 2000000, "1999-03-27 11:30:09 -0800")
      account.withdraw(1100000)
      account.deposit(1100000)
      account.withdraw(1000000).must_equal 1000000
    end

    # If a deposit causes the balance to be greater than equal to $10,000, that deposit does not add to num_transaction
    it "Does not increase num_transaction, when deposit causes the balance to be greater than equal to $10,000" do
      account = Bank::MoneyMarketAccount.new(12345, 2000000, "1999-03-27 11:30:09 -0800")
      account.withdraw(1100000)
      account.deposit(1100000)
      account.num_transaction.must_equal 1
    end

    # With each deposit, the num_transaction count goes up by 1
    it "Each deposit transaction will be counted against the maximum number of transactions" do
      account = Bank::MoneyMarketAccount.new(12345, 2000000, "1999-03-27 11:30:09 -0800")
      account.deposit(1100)
      account.deposit(1100)
      account.num_transaction.must_equal 2
    end

    # Transaction is not allowed when the num_transaction is greater than equal to 6
    it "Doesn't modify the balance if the num_transaction is greater than equal to 6" do
      account = Bank::MoneyMarketAccount.new(12345, 2000000, "1999-03-27 11:30:09 -0800")
      account.num_transaction = 6
      account.deposit(1100000).must_equal 2000000
    end
  end

  xdescribe "#add_interest" do
    # Only the actual interest amount added is returned
    it "Returns the interest calculated" do
      Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800").add_interest(0.25).must_equal 250000
    end
    # Balance is updated
    it "Updates the balance with calculated interest" do
      account = Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800").add_interest(0.25).must_equal 250000
      account.add_interest(0.25)
      account.balance.must_equal 1250000
    end
    # Checks against erroneous rate value inputs
    it "Requires a positive rate" do
      proc {
        Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800").add_interest(-0.32)
      }.must_raise ArgumentError
    end
  end

  describe "#reset_transactions" do
    #  Resets the number of transactions to zero
    it "Resets the num_transaction to 0" do
      account = Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800")
      5.times do
        account.withdraw(1000)
      end
      account.new_month = true
      account.reset_transactions
      account.num_transaction.must_equal 0
    end

    # When the num_transaction is zero, calling this method outputs a message
    it "Outputs a message when the num_transaction is already 0" do
      account = Bank::MoneyMarketAccount.new(12345, 1000000, "1999-03-27 11:30:09 -0800")
      account.new_month = true
      proc {
        account.reset_transactions
      }.must_output (/.+/)
    end
  end
end
