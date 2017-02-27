require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'rake/testtask'
require_relative '../lib/savings_account'
require_relative '../lib/account'

describe "SavingsAccount" do

  describe "#initialize" do
    it "Is a kind of Account" do
      account = Bank::SavingsAccount.new(12345, 10000)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      account = Bank::SavingsAccount.new(12345, 20000)
      account.balance.must_be :> , 10
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      account = Bank::SavingsAccount.new(12345, 10000)
      withdrawal_amount = 800


      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal 9000
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 20000
      withdrawl_amount = 20000
      account = Bank::SavingsAccount.new(1337, start_balance)

      proc {
        account.withdraw(withdrawl_amount)
      }.must_output(/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      account = Bank::SavingsAccount.new(12345, 20000 )

      account_balance = account.balance

      account_balance.must_equal 20000

    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      account = Bank::SavingsAccount.new(12345, 100000 )
      withdrawal_amount = 100000
      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_be :>, 1000


    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      account = Bank::SavingsAccount.new(12345, 100000 )
      added_interest =  account.add_interest(10)
      added_interest.must_equal 10000

    end

    it "Updates the balance with calculated interest" do
      account = Bank::SavingsAccount.new(12345, 100000 )
      added_interest =  account.add_interest(10)
      account.balance.must_equal 110000
    end

    it "Requires a positive rate" do
      account = Bank::SavingsAccount.new(12345, 100000 )

      proc {
        account.add_interest(-0.25)
      }.must_raise ArgumentError
    end
  end
end
