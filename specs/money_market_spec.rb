require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/money_market'


describe "MoneyMarketAccount" do
  describe "#initialize" do

    it "Is a kind of Account" do
      account = Bank::MoneyMarketAccount.new(12345, 10000)
      account.must_be_kind_of Bank::Account
    end

    it "Must be initialized with a balance of $10,000" do
      proc {
        Bank::MoneyMarketAccount.new(12345, 9999)
      }.must_raise ArgumentError
    end

  end

  describe "#withdrawal" do

    it "Imposes a $100 fee if the balance goes below $10,000" do
      account = Bank::MoneyMarketAccount.new(12345, 10000)
      account.withdraw(500)
      account.balance.must_equal 9400
    end

    it "Doesn't allow anymore transactions if the balance goes below $10000" do
      account = Bank::MoneyMarketAccount.new(12345, 10000)
      account.withdraw(500)
      proc {
        account.withdraw(500)
      }.must_output(/.+/)
      account.balance.must_equal 9400
    end

  end

end
