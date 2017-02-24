require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

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

      id = 12345
      starting_balance = 10
      open_date = 20170101
      account = Bank::SavingsAccount.new(id, starting_balance,open_date)

      # Check that a SavingsAccount is in fact a kind of account
      # edited to include 3 arguments
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      # TODO: Your test code here!
      id = 12345
      starting_balance = 9
      open_date = 20170101


      proc {
        Bank::SavingsAccount.new(id, starting_balance, open_date)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do

    before do

      id = 12345
      starting_balance = 100
      open_date = 20170101
      @account = Bank::SavingsAccount.new(id, starting_balance,open_date)

    end

    it "Applies a $2 fee each time" do
      # TODO: Your test code here!
      withdrawal_amount = 10
      @account.withdraw(withdrawal_amount).must_equal 88
    end

    it "Outputs a warning if the balance would go below $10" do
      # TODO: Your test code here!
      withdrawal_amount = 99
      proc {
        @account.withdraw(withdrawal_amount)
      }.must_output /.+/

    end

    it "Doesn't modify the balance if it would go below $10" do
      # TODO: Your test code here!
      @account.withdraw(99).must_equal 100
    end


    it "Doesn't modify the balance if the fee would put it below $10" do
      # TODO: Your test code here!
      @account.withdraw(90).must_equal 100

    end
  end

  describe "#add_interest" do

    it "Returns the interest calculated" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      rate = 0.25

      account = Bank::SavingsAccount.new(id, starting_balance, open_date)
      # TODO: Your test code here!
      account.add_interest(rate).must_equal 0.25
    end

    it "Updates the balance with calculated interest" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      rate = 0.25

      account = Bank::SavingsAccount.new(id, starting_balance, open_date)
      # TODO: Your test code here!
      account.add_interest(0.25)
      account.balance.must_equal 100.25
    end

    it "Requires a positive rate" do
      id = 12345
      starting_balance = 100
      open_date = 20170101
      rate = 0
      account = Bank::SavingsAccount.new(id, starting_balance, open_date)

      # TODO: Your test code here!
      proc {
        account.add_interest(rate)
      }.must_raise ArgumentError

    end
  end
end
