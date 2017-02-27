require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
# require 'savings_account'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do

    proc{
        Bank::SavingsAccount.new(117, 9)
    }.must_raise ArgumentError
    end
  end



  describe "#withdraw" do
    it "Applies a $2 fee each time" do
        id = 116
        balance = 20
        fee = 2
        amount = 2
        account = Bank::SavingsAccount.new(id,balance)
        account.withdraw(amount)
        account.balance.must_equal balance - (amount + fee)
    end



    it "Outputs a warning if the balance would go below $10" do
        id = 116
        balance = 20
        amount = 11
        account = Bank::SavingsAccount.new(id, balance)


        proc{
            account.withdraw(amount)
        }.must_output( /.+/)

    end




    it "Doesn't modify the balance if it would go below $10" do
        id = 116
        balance = 20
        amount = 11
        account = Bank::SavingsAccount.new(id, balance)
        account.withdraw(amount)

        account.balance.must_equal balance
    end



    it "Doesn't modify the balance if the fee would put it below $10" do
        id = 116
        balance = 20
        account = Bank::SavingsAccount.new(id, balance)

        account.balance.must_equal balance
    end
  end


#this does not work and i don't understand for the life of me!
  describe "#add_interest" do
    it "Returns the interest calculated" do
        id = 116
        balance = 10000
        rate = 0.25
        interest = balance * rate/100

        account = Bank::SavingsAccount.new(id,balance)
        account.add_interest(rate).must_equal interest
    end




    it "Updates the balance with calculated interest" do
        id = 116
        balance = 10000
        rate = 0.25
        interest = balance * rate/100
        new_balance = interest + balance


        account = Bank::SavingsAccount.new(id,balance)
        account.add_interest(rate)
        account.balance.must_equal new_balance
    end


    it "Requires a positive rate" do
        id = 116
        balance = 10000
        rate = -0.25


        account = Bank::SavingsAccount.new(id,balance)

        proc{
            account.add_interest(rate)
        }.must_output( /.+/)

    end
  end
end
