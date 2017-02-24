require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savingsaccount'
require 'date'


  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(1337, 9.99)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      total_withdrawl = withdrawal_amount + 2
      account = Bank::SavingsAccount.new(1337, start_balance)
      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - total_withdrawl
      account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 91.0
      account = Bank::SavingsAccount.new(1337, start_balance)
      #This is a proc with a regex that requires a string in order for the test to pass
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 91.0
      account = Bank::SavingsAccount.new(1337, start_balance)
       if account.balance - withdrawal_amount < 10
         account.withdraw(withdrawal_amount).must_equal start_balance
       end
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 100.0
      withdrawal_amount = 91.0
      total_withdrawl = withdrawal_amount + 2
      account = Bank::SavingsAccount.new(1337, start_balance)
       if account.balance - total_withdrawl < 10
         account.withdraw(withdrawal_amount).must_equal start_balance
       end
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      start_balance = 10000.0
      account = Bank::SavingsAccount.new(1337, start_balance)
      account.add_interest(0.25).must_equal start_balance * 1.0025
    end

    it "Updates the balance with calculated interest" do
        start_balance = 10000.00
        account = Bank::SavingsAccount.new(1337,start_balance)
        account.add_interest(0.25).must_equal 10025
    end

    it "Requires a positive rate" do
      start_balance = 10000.0
      rate = -0.2
      account = Bank::SavingsAccount.new(1337, start_balance)
      account.add_interest(rate)

      proc {
        account.add_interest(rate)
      }.must_output (/.+/)
    end
  end
