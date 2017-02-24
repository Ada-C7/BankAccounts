require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'
require_relative '../lib/account'
Minitest::Reporters.use!

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
      account = Bank::CheckingAccount.new(1234, 100)
      amount_to_withdraw = 10
      expected_result = account.balance - amount_to_withdraw - 1
      account.withdraw(amount_to_withdraw).must_equal expected_result
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      balance = 100
      amount_to_withdraw = 100
      account = Bank::CheckingAccount.new(1234, balance)
      puts account.withdraw(amount_to_withdraw)
      account.withdraw(amount_to_withdraw).must_equal balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      account = Bank::CheckingAccount.new(1234, 100)
      balance = account.balance
      result = account.withdraw_using_check(50)
      result.must_be :<, balance
    end

    it "Returns the modified balance" do
      account = Bank::CheckingAccount.new(1234, 100)
      amount = 10
      result = account.withdraw_using_check(amount)
      expected_result =  100 - amount
      result.must_equal expected_result
    end

    it "Allows the balance to go down to -$10" do
      account = Bank::CheckingAccount.new(1234, 100)
      amount_to_withdraw = 110
      result = account.withdraw_using_check(amount_to_withdraw)
      result.must_equal (-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      account = Bank::CheckingAccount.new(1234, 100)
      amount_to_withdraw = 90
      proc {
        account.withdraw_using_check(amount_to_withdraw)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      balance = 100
      amount_to_withdraw = 111
      account = Bank::CheckingAccount.new(1234, balance)
      account.withdraw_using_check(amount_to_withdraw).must_equal 100
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100
      withdrawal_amount = -25
      account = Bank::CheckingAccount.new(1337, start_balance)
      proc {
        account.withdraw_using_check(withdrawal_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      amount = 10
      account = Bank::CheckingAccount.new(1337, 100)
      account.withdraw_using_check(amount)
      account.withdraw_using_check(amount)
      account.withdraw_using_check(amount)
      account.balance.must_equal 70
      account.withdraw_using_check(amount)
      account.balance.must_equal 58
    end

    it "Applies a $2 fee after the third use" do
      amount = 10
      fee = 2
      account = Bank::CheckingAccount.new(1337, 100)
      account.withdraw_using_check(amount)
      account.withdraw_using_check(amount)
      account.withdraw_using_check(amount)
      result = account.withdraw_using_check(amount)
      expected_result = 100 - (4*10) - fee
      result.must_equal expected_result
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      account = Bank::CheckingAccount.new(1337, 100)
      account.reset_checks
      account.check_uses.must_equal 0
    end
    # Method runs withdraw_using_check number of times
    # for next two tests:
    def run_withdraw_using_check(number, account, amount)
      number.times do
        account.withdraw_using_check(amount)
      end
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
        account = Bank::CheckingAccount.new(1337, 100)
        amount = 10
        run_withdraw_using_check(2, account, amount)
        account.reset_checks
        run_withdraw_using_check(2, account, amount)

        result =account.withdraw_using_check(amount)
        result.must_equal 50
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
        account = Bank::CheckingAccount.new(1337, 100)
        amount = 10
        run_withdraw_using_check(4, account, amount)

        account.check_uses.must_equal 4
        account.reset_checks
        account.check_uses.must_equal 0

        run_withdraw_using_check(3, account, amount)

        account.check_uses.must_equal 3
    end
  end
end
