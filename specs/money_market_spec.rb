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


  end
end
