require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0, "date")
      account.must_be_kind_of Bank::Account, "Sorry - that is not an account."
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(12345, 8.0, "date")
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::SavingsAccount.new(1337, start_balance, "date")

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount - 2
      account.balance.must_equal expected_balance, "Two dollar fee was not applied."
    end

    it "Outputs a warning if the balance would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 89.0
      account = Bank::SavingsAccount.new(1337, start_balance, "date")
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if it would go below $10" do
      start_balance = 100.0
      withdrawal_amount = 95.0
      account = Bank::SavingsAccount.new(1337, start_balance, "date")

      account.withdraw(withdrawal_amount)

      account.balance.must_equal start_balance, "Balance was modified when it shouldn't have been."
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 100.0
      withdrawal_amount = 89.0
      account = Bank::SavingsAccount.new(1337, start_balance, "date")

      account.withdraw(withdrawal_amount)

      account.balance.must_equal start_balance, "Balance was modified even though the fee dropped it below $10."
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      start_balance = 10000.0
      rate = 0.25
      account = Bank::SavingsAccount.new(1337,start_balance, "date")

      interest = account.add_interest(rate)

      interest.must_equal start_balance * (rate / 100), "Calculated interest was not returned."
    end

    it "Updates the balance with calculated interest" do
      start_balance = 10000.0
      rate = 0.25
      account = Bank::SavingsAccount.new(1337,start_balance, "date")

      account.add_interest(rate)

      account.balance.must_equal (start_balance + (start_balance * (rate / 100))), "Balance was not updated with calculated interest."
    end

    it "Requires a positive rate" do
      account = Bank::SavingsAccount.new(12345, 100.0, "date")
        proc {
          account.add_interest(-0.25)
        }.must_raise ArgumentError
    end
  end
end
