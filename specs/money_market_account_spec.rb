require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/money_market'

describe "SavingsAccount" do
  before do
    @account = Bank::MoneyMarketAccount.new(12345, 10000, "1999-03-27 11:30:09 -0800")
  end


end
