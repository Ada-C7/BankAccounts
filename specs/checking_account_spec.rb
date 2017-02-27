require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'

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
      start_balance = 100.0
      withdrawal_amount = 25.0
      fee = 1.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount - fee

      # Both the value returned and the balance in the account
      # should apply the fee
      updated_balance.must_equal expected_balance
      account.balance.must_equal expected_balance
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      start_balance = 100.0
      withdrawal_amount = 100.0 # + $1 fee
      account = Bank::CheckingAccount.new(12345, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      # Add for possible check fee here or assume brand new account?
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      account.withdraw_using_check(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount

      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      updated_balance = account.withdraw_using_check(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount

      updated_balance.must_equal expected_balance
    end

    it "Allows the balance to go down to -$10" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      updated_balance = account.withdraw_using_check(account.balance + 10.0)

      updated_balance.must_equal (-10)
      account.balance.must_equal (-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      # Anything printed to the console output will pass the test
      proc {
        account.withdraw_using_check(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      updated_balance = account.withdraw_using_check(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Requires a positive withdrawal amount" do
      withdrawal_amount = -25.0
      account = Bank::CheckingAccount.new(12345, 100.0)

      proc {
        account.withdraw_using_check(withdrawal_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      updated_balance = mulitple_check_withdrawal(3, account, withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount * 3

      account.balance.must_equal expected_balance
      updated_balance.must_equal expected_balance
    end

    it "Applies a $2 fee after the third use" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      fee = 2.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      updated_balance = mulitple_check_withdrawal(4, account, withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount * 4 - fee

      account.balance.must_equal expected_balance
      updated_balance.must_equal expected_balance
    end
  end

  # Calls withdraw_using_check num times
  # returns updated_balance
  def mulitple_check_withdrawal(num, account, withdrawal_amount)
    updated_balance = nil
    num.times do
      updated_balance = account.withdraw_using_check(withdrawal_amount)
    end
    updated_balance
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.reset_checks
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      start_balance = 200.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      mulitple_check_withdrawal(2, account, withdrawal_amount)
      account.reset_checks
      mulitple_check_withdrawal(3, account, withdrawal_amount)

      expected_balance = 200.0 - withdrawal_amount * 5

      account.balance.must_equal expected_balance
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      start_balance = 200.0
      withdrawal_amount = 25.0
      fee = 2.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      mulitple_check_withdrawal(4, account, withdrawal_amount)
      account.reset_checks
      mulitple_check_withdrawal(3, account, withdrawal_amount)

      expected_balance = 200.0 - withdrawal_amount * 7 - fee

      account.balance.must_equal expected_balance
    end
  end
end
