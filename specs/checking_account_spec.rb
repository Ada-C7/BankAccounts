require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'
require_relative '../lib/account.rb'

describe "CheckingAccount" do

  describe "#initialize" do
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::CheckingAccount
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw(10).must_equal(89)
      account.balance.must_equal(89)
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw(100).must_equal(100)
    end
  end
  #
  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw_using_check(50.0)
      account.balance.must_equal(50.0)
    end

    it "Returns modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(12345, start_balance)
      updated_balance = account.withdraw_using_check(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    #
    it "Allows the balance to go down to -$10" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw_using_check(110.0)
      account.balance.must_equal(-10.0)
    end
    #
    it "Outputs a warning if the account would go below -$10" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      proc {
        account.withdraw_using_check(111.0)
      }.must_output (/.+/)
    end
    #
    it "Doesn't modify the balance if the account would go below -$10" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.withdraw_using_check(111.0)
      account.balance.must_equal(100.0)
    end
  end
  #
  it "Requires a positive withdrawal amount" do
    account = Bank::CheckingAccount.new(12345, 100.0)
    proc {
      account.withdraw(-5)
    }.must_raise ArgumentError
  end
  #
  it "Allows 3 free uses" do
    account = Bank::CheckingAccount.new(12345, 100.0)
    3.times do
      previous_balance = account.balance
      account.withdraw_using_check(25.0)
      expected_withdrawal = 25.0
      expected_balance = previous_balance - expected_withdrawal
      account.balance.must_equal expected_balance
    end
  end
  #
  it "Applies a $2 fee after the third use" do
    account = Bank::CheckingAccount.new(12345, 100.0)
    3.times do
      previous_balance = account.balance
      account.withdraw_using_check(25.0)
      expected_withdrawal = 25.0
      expected_balance = previous_balance - expected_withdrawal
      account.balance.must_equal expected_balance
    end
account = Bank::CheckingAccount.new(12345, 100.0)
    2.times do
      previous_balance = account.balance
      account.withdraw_using_check(25.0)
      expected_withdrawal = 27.0
      expected_balance = previous_balance - expected_withdrawal
      account.balance.must_equal expected_balance
    end
  end
  #
  describe "#reset_checks" do
    it "Can be called without error" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.reset_checks.must_equal(0)
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      2.times do
        account.withdraw_using_check(25.0)
      end
      account.reset_checks
      account.check_count.must_equal(0)
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      4.times do
        account.withdraw_using_check(25.0)
      end
      account.reset_checks
      account.check_count.must_equal(0)
    end
  end
end
