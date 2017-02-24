require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do
  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end
  end



  describe "#withdraw" do
    it "Applies a $1 fee each time" do
        id = 16
        balance = 20


        account = Bank::CheckingAccount.new(id, balance)
        account.withdraw(9)
        account.balance.must_equal 10
    end


    it "Doesn't modify the balance if the fee would put it negative" do
        id = 16
        balance = 20

        account = Bank::CheckingAccount.new(id, balance)
        account.withdraw(20)
        account.balance.must_equal balance
    end
  end


  describe "#withdraw_using_check" do
    it "Reduces the balance" do
        id = 116
        balance = 20
        amount = 15

        account = Bank::CheckingAccount.new(id, balance)
        account.withdraw_using_check(amount)
        account.balance.must_be :<, balance
    end

    it "Returns the modified balance" do
        id = 116
        balance = 20
        amount = 15
        new_balance = balance - amount

        account = Bank::CheckingAccount.new(id,balance)
        account.withdraw_using_check(amount)
        account.balance.must_equal new_balance
    end


    it "Allows the balance to go down to -$10" do
        id = 116
        balance = 10
        amount = 20

        account = Bank::CheckingAccount.new(id, balance)
        account.withdraw_using_check(amount)
        account.balance.must_equal (balance - amount)
    end


    it "Outputs a warning if the account would go below -$10" do
     id = 116
     balance = 10
     amount = 21

     account = Bank::CheckingAccount.new(id, balance)

     proc{
        account.withdraw_using_check(amount)
     }.must_output( /.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
        id = 116
        balance = 10
        amount = 21

        account = Bank::CheckingAccount.new(id, balance)
        account.withdraw_using_check(amount)
        account.balance.must_equal balance
    end

    it "Requires a positive withdrawal amount" do
        id = 116
        balance = 10

        account = Bank::CheckingAccount.new(id, balance)
        account.balance.must_equal balance
    end








    it "Allows 3 free uses" do
        id = 116
        balance = 200
        amount = 10

        account = Bank::CheckingAccount.new(id, balance)
        3.times do account.withdraw_using_check(amount) end
        account.balance.must_equal (balance - (3 * amount))
    end





















    it "Applies a $2 fee after the third use" do
        # account.withdraw_using_check(amount)
        # account.balance.must_equal ((balance - (4 * amount)) - 2)
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # TODO: Your test code here!
    end
  end
end
