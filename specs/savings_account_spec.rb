require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
# require_relative '../lib/savings_account'


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
      # account = Bank::SavingsAccount.new(3453, 8)

      # TODO: Your test code here!
      proc {
        Bank::SavingsAccount.new(1337, 4.0)
      }.must_raise ArgumentError

    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 300.0
      withdrawal_amount = 120.0
      account = Bank::SavingsAccount.new(12345, start_balance)

      account.withdraw(withdrawal_amount)


      expected_balance = start_balance - withdrawal_amount - 2.0
      account.balance.must_equal expected_balance
      # TODO: Your test code here!
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 300.0
      withdrawal_amount = 291.0
      account = Bank::SavingsAccount.new(1234, start_balance)

      # account.withdraw(withdrawal_amount)

      proc {
        account.withdraw(withdrawal_amount)
      }.must_output /.+/


      # TODO: Your test code here!
    end

    it "Doesn't modify the balance if it would go below $10" do
        # TODO: Your test code here!
        start_balance = 300.0
        withdrawal_amount = 291.0
        account = Bank::SavingsAccount.new(1234, start_balance)
        updated_balance = account.withdraw(withdrawal_amount)

        updated_balance.must_equal start_balance
        account.balance.must_equal start_balance

    end

    it "Doesn't modify the balance if the fee would put it below $10" do

      start_balance = 300.0
      withdrawal_amount = 289.0
      account = Bank::SavingsAccount.new(1234, start_balance)
      updated_balance = account.withdraw(withdrawal_amount)

      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance

      # TODO: Your test code here!
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      account = Bank::SavingsAccount.new(1234, 120)

      interest = account.add_interest(25.0)

      interest.must_equal 30

      # TODO: Your test code here!
    end

    it "Updates the balance with calculated interest" do
      

      # TODO: Your test code here!
    end

    it "Requires a positive rate" do
      skip
      # TODO: Your test code here!
    end
  end
end
