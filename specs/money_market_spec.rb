require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/money_market'
require_relative '../lib/account'
Minitest::Reporters.use!

describe "MoneyMarket" do
  it "Is a kind of Account" do
    account = Bank::MoneyMarket.new(12345, 1000000)
    account.must_be_kind_of Bank::Account
  end
  it "Error if initial balance < 10000" do
    proc {
      Bank::MoneyMarket.new(100, 500)
    }.must_raise ArgumentError
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      account = Bank::MoneyMarket.new(1234, 20000)
      amount_to_withdraw = 1000
      expected_result = account.balance - amount_to_withdraw
      account.withdraw(amount_to_withdraw).must_equal expected_result
    end

    it "Return modified balance" do
      account = Bank::MoneyMarket.new(1234, 20000)
      amount = 1000
      result = account.withdraw(amount)
      expected_result =  20000 - amount
      result.must_equal expected_result
    end

    it "Decreases number of maximum transactions" do
      account = Bank::MoneyMarket.new(1234, 20000)
      before_calling = account.maximum_transactions
      account.withdraw(500)
      after_calling = account.maximum_transactions
      result  = before_calling - after_calling
      result.must_equal 1
    end
    it "Return unmodified balance if balance is < 10000" do
      account = Bank::MoneyMarket.new(1234, 20000)
      balance = account.withdraw(15000)
      balance_2 = account.withdraw(500)
      balance.must_equal balance_2
    end

    it "Applies 100$ fee if balance is < 10000 after withdrawal" do
      account = Bank::MoneyMarket.new(1234, 20000)
      account.withdraw(15000)
      expected_balance = 20000 - 15000 - 100
      account.balance.must_equal expected_balance
    end

    it "Does not allow to withdraw if limit of max_transaction is exceeded" do
      account = Bank::MoneyMarket.new(1234, 20000)
      account.withdraw(100)
      account.withdraw(100)
      account.withdraw(100)
      account.withdraw(100)
      account.withdraw(100)
      account.withdraw(100)
      current_balance = account.balance
      balance_after_6_withdraws = account.withdraw(100)
      current_balance.must_equal balance_after_6_withdraws
    end
  end # end of withdraw

  describe "#deposit" do
    it "Decrease maximum_transactions" do
      account = Bank::MoneyMarket.new(1234, 20000)
      account.deposit(1000)
      account.maximum_transactions.must_equal 5
    end

    it "Doesn't decrease maximum_transactions if deposit
       performed to exceed the minimum balance
       of $10,000" do
      account = Bank::MoneyMarket.new(1234, 20000)
      account.withdraw(15000) # decreases maximum_transactions by one
      account.deposit(1000) # doesn't decrease maximum_transactions
      account.maximum_transactions.must_equal 5
    end
  end

  describe "#add_interest(rate)" do
    it "Returns the interest calculated" do
      account = Bank::MoneyMarket.new(1234, 10000)
      rate = 0.25
      expected_interest = account.balance * rate/100
      account.add_interest(rate).must_equal expected_interest
    end

    it "Updates the balance with calculated interest" do
      account = Bank::MoneyMarket.new(1234, 10000)
      current_balance = account.balance
      rate = 0.25
      interest_amount = account.add_interest(rate)
      (current_balance + interest_amount).must_equal account.balance
    end

    it "Requires a positive rate" do
      account = Bank::MoneyMarket.new(1234, 10000)
      rate = -2
      proc {
        account.add_interest(rate)
      }.must_raise ArgumentError
    end
  end

  describe "#reset_transactions:" do
    it "Number of thransactoins == 0" do
      account = Bank::MoneyMarket.new(1234, 20000)
      account.withdraw(100)
      account.withdraw(100)
      account.reset_transactions
      num_of_trans = account.maximum_transactions
      num_of_trans.must_equal 0
    end
  end

end #end of MoneyMarket
