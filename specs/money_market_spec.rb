require_relative 'spec_helper.rb'

# Create a MoneyMarketAccount class which should inherit behavior from the Account class.
xdescribe "MoneyMarketAccount" do

  describe "#initialize" do

    it "Is a kind of Account" do
      account = Bank::MoneyMarketAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Raises an error if initial balance is less than $10,000" do
      proc {Bank::MoneyMarketAccount.new(12345, 100)}.must_raise ArgumentError
    end

  end


  xdescribe "#withdraw" do

    before do
      @account = Bank::MoneyMarketAccount.new(12345, 15000.0)
    end

    it "Charges a fee of $100 if the balance goes below $10,000." do
      @account.withdraw(6000)
      @account.balance.must_equal 8900
      proc {@account.withdraw(10)}.must_raise ArgumentError
      @account.deposit(10000)
      @account.withdraw(500)
      @account.balance.must_equal 18400
    end

  end

  xdescribe "#track_transactions" do

  end


  xdescribe "#add_interest" do

      before do
        @account = Bank::MoneyMarketAccount.new(12345, 100.0)
      end

      it "Returns the interest calculated" do
        @account.add_interest(0.25)
        @account.interest.must_equal(0.25)
      end

      it "Updates the balance with calculated interest" do
        @account.add_interest(0.25)
        @account.balance.must_equal(100.25)
      end

      it "Requires a positive rate" do
        proc {@account.add_interest(-0.25)}.must_raise ArgumentError
      end

  end

end


# Each transaction will be counted against the maximum number of transactions

# Updated deposit logic: Each transaction will be counted against the maximum
# number of transactions. Exception to the above: A deposit performed to reach
# or exceed the minimum balance of $10,000 is not counted as part of the 6 transactions.
# #add_interest(rate): Calculate the interest on the balance and add the interest
# to the balance. Return the interest that was calculated and added to the balance
# (not the updated balance). Note** This is the same as the SavingsAccount interest.
# #reset_transactions: Resets the number of transactions to zero
