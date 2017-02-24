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
      # Check that a SavingsAccount is in fact a kind of account
      id = 12345
      balance = 100.0
      account = Bank::SavingsAccount.new(id, balance)
      account.must_be_kind_of Bank::Account

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance
    end
  end
  #     it "Requires an initial balance of at least $10" do
  #       # TODO: Your test code here!
  it "Raises an ArgumentError when initial balance is less than $10" do
    proc {
      Bank::SavingsAccount.new(13371, 5.0)
    }.must_raise ArgumentError
  end
end
describe "#withdraw" do
  it "Applies a $2 fee each time" do
    # TODO: Your test code here!
    start_balance = 100.0
    withdrawal_amount = 25.0
    account = Bank::SavingsAccount.new(13371, start_balance)

    account.withdraw(withdrawal_amount)

    expected_balance = start_balance - (withdrawal_amount+2)
    account.balance.must_equal expected_balance
  end

  it "Outputs a warning if the balance would go below $10" do
    # TODO: Your test code here!
    start_balance = 100.0
    withdrawal_amount = 91.0
    account = Bank::SavingsAccount.new(13371, start_balance)
    proc {
      account.withdraw(withdrawal_amount)
    }.must_output /.+/
  end

  it "Doesn't modify the balance if it would go below $10" do
    # TODO: Your test code here!
    start_balance = 100.0
    withdrawal_amount = 91.0
    account = Bank::SavingsAccount.new(13371, start_balance)

    updated_balance = account.withdraw(withdrawal_amount)

    # Both the value returned and the balance in the account
    # must be un-modified.
    updated_balance.must_equal start_balance
    account.balance.must_equal start_balance

  end

  it "Doesn't modify the balance if the fee would put it below $10" do
    # TODO: Your test code here!
    start_balance = 100.0
    withdrawal_amount = 89.0
    account = Bank::SavingsAccount.new(13371, start_balance)

    updated_balance = account.withdraw(withdrawal_amount)

    # Both the value returned and the balance in the account
    # must be un-modified.
    updated_balance.must_equal start_balance
    account.balance.must_equal start_balance
  end
end


describe "#add_interest" do
  it "Returns the interest calculated" do
    # TODO: Your test code here!
    account = Bank::SavingsAccount.new(13371, 10000)
    account.add_interest(0.25).must_equal 25
  end

  it "Updates the balance with calculated interest" do
    # TODO: Your test code here!
    account = Bank::SavingsAccount.new(13371, 10000)
    account.add_interest(0.25)
    account.balance.must_equal 10025
  end

  it "Requires a positive rate" do
    # TODO: Your test code here!
    account = Bank::SavingsAccount.new(13371, 10000)
    proc {
      account.add_interest(-0.25)
    }.must_raise ArgumentError
    end
  end
