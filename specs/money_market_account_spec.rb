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
end
