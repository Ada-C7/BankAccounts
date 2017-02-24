require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/money_market_account'

#Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "MoneyMarketAccount" do

  describe "#initialize" do

    # Check that a MoneyMarketAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::MoneyMarketAccount.new(12345, 10000)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10,000" do
      proc {
        Bank::MoneyMarketAccount.new(1337, 9999)
      }.must_raise ArgumentError
    end
  end

  describe "Maximum of 6 transacctions" do

    it "increases the transaction count when either a withdrawal or a deposit is made." do
      account = Bank::MoneyMarketAccount.new(12345, 50000)
      withdrawal_amount = 100
      deposit_amount = 300
      account.withdraw(withdrawal_amount)
      account.deposit(deposit_amount)
      account.transaction_count.must_equal 2
    end

    it "Outputs a message when a transaction is attempted after 6 transactions have been made." do
      withdrawal_amount = 100
      deposit_amount = 300
      account = Bank::MoneyMarketAccount.new(1337, 50000)
      3.times {account.withdraw(withdrawal_amount)}
      3.times {account.deposit(deposit_amount)}
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output(/.+/)
      proc {
        account.deposit(deposit_amount)
      }.must_output(/.+/)
    end

    it "Does not implement a requested transaction or modify the balance after 6 transactions have been made." do
      withdrawal_amount = 100
      deposit_amount = 300
      account = Bank::MoneyMarketAccount.new(1337, 50000)
      6.times {account.withdraw(withdrawal_amount)}
      updated_balance = account.balance
      account.deposit(deposit_amount)
      account.withdraw(withdrawal_amount)
      account.balance.must_equal updated_balance
    end
  end

  describe "#withdraw" do

    it "Deducts a $100 fee if the balance would go below $10000" do
      start_balance = 11000
      withdrawal_amount = 2000
      account = Bank::MoneyMarketAccount.new(1337, start_balance)
      account.withdraw(withdrawal_amount)
      updated_balance = start_balance - withdrawal_amount - 100
      account.balance.must_equal updated_balance
    end

    it "Outputs a 'disallowed' message if the balance has not been increased using a deposit transaction" do
      start_balance = 11000
      withdrawal_amount = 2000
      account = Bank::MoneyMarketAccount.new(1337, start_balance)
      account.withdraw(withdrawal_amount)
      proc {
        account.withdraw(10)
      }.must_output(/.+/)
    end

    it "Does not change balance upon withdrawal attempt if the balance has not been increased using a deposit transaction" do
      start_balance = 11000
      withdrawal_amount = 2000
      account = Bank::MoneyMarketAccount.new(1337, start_balance)
      account.withdraw(withdrawal_amount)
      updated_balance = account.balance

      account.withdraw(10)
      account.balance.must_equal updated_balance
    end

    it "Implements new transactions once the balance has been increased using a deposit transaction" do
      start_balance = 11000
      withdrawal_amount = 2000
      account = Bank::MoneyMarketAccount.new(1337, start_balance)
      account.withdraw(withdrawal_amount)
      deposit_amount = 5000
      account.deposit(deposit_amount)
      updated_balance = account.balance
      account.withdraw(100)
      account.balance.must_equal (updated_balance - 100)
    end

  end
end
