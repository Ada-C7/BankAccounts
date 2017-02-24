require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/money_market_account'

describe "MoneyMarketAccount" do

  describe "initialize" do

    it "raises error when initialized with less than $10,000" do
      id = 12345
      starting_balance = 9999
      open_date = 20170101

      proc {
        Bank::MoneyMarketAccount.new(id, starting_balance, open_date)
      }.must_raise ArgumentError
    end
  end


  describe "#withdraw" do

    it "text" do

    end

  end

  describe "#deposit" do

    it do

    end

  end
end
