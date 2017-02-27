require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 50000,0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      # TODO: Your test code here!
      proc {
        Bank::SavingsAccount.new(1337, 500, "NA")
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 12000
      withdrawal_amount = 1800
      account = Bank::SavingsAccount.new(1337, start_balance, "NA")

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount - 200
      account.balance.must_equal expected_balance
    end
  end


  it "Outputs a warning if the balance would go below $10" do
    start_balance = 1000
    withdrawal_amount = 200
    account = Bank::SavingsAccount.new(1337, start_balance,"NA")
    # Another proc! This test expects something to be printed
    # to the terminal, using 'must_output'. /.+/ is a regular
    # expression matching one or more characters - as long as
    # anything at all is printed out the test will pass.
    proc {
      account.withdraw(withdrawal_amount)
    }.must_output /.+/
  end

  it "Doesn't modify the balance if it would go below $10" do
    start_balance = 1000
    withdrawal_amount = 200.0
    account = Bank::SavingsAccount.new(1337, start_balance, "NA")

    updated_balance = account.withdraw(withdrawal_amount)

    # Both the value returned and the balance in the account
    # must be un-modified.
    updated_balance.must_equal start_balance
    account.balance.must_equal start_balance
  end

  it "Doesn't modify the balance if the fee would put it below $10" do
    start_balance = 1399
    withdrawal_amount = 200
    account = Bank::SavingsAccount.new(1337, start_balance, "NA")

    updated_balance = account.withdraw(withdrawal_amount)

    # Both the value returned and the balance in the account
    # must be un-modified.
    updated_balance.must_equal start_balance
    account.balance.must_equal start_balance
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      start_amount = 10000
      account = Bank::SavingsAccount.new(1337, start_amount, "NA")
      rate = 0.25
      expected_interest = start_amount * rate/100
      account.add_interest(rate).must_equal expected_interest
    end

    it "Updates the balance with calculated interest" do
      start_amount = 10000
      account = Bank::SavingsAccount.new(1337, start_amount, "NA")
      rate = 0.25

      expected_balance = start_amount * (1 + rate/100)

      account.add_interest(rate)
      account.balance.must_equal expected_balance
    end

    it "Requires a positive rate" do
      start_balance = 1000
      rate = -0.25
      account = Bank::SavingsAccount.new(1337, start_balance,"NA")
      # Another proc! This test expects something to be printed
      # to the terminal, using 'must_output'. /.+/ is a regular
      # expression matching one or more characters - as long as
      # anything at all is printed out the test will pass.
      proc {
        account.add_interest(rate)
      }.must_raise ArgumentError
    end
  end
end
