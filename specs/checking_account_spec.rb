require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'

describe "CheckingAccount" do
  describe "#initialize" do
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
      account = Bank::CheckingAccount.new(1212, start_balance)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount - fee
      account.balance.must_equal expected_balance
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      start_balance = 100
      withdraw_amount = 101
      account = Bank::CheckingAccount.new(1212, start_balance)
      x = account.withdraw(withdraw_amount)

      x.must_equal start_balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      start_balance = 876
      amount = 76
      account = Bank::CheckingAccount.new(17682, start_balance)
      balance1 = start_balance - amount
      account.withdraw_using_check(amount).must_be_same_as balance1
    end

    it "Returns the modified balance" do
      start_balance = 100
      amount = 70
      account = Bank::CheckingAccount.new(17682, start_balance)
      updated_balance = start_balance - amount

      updated_balance.must_equal account.withdraw_using_check(amount)
    end

    it "Allows the balance to go down to -$10" do
      start_balance = 1000
      withdrawal_amount = 1010
      account = Bank::CheckingAccount.new(1879, start_balance)
      account.withdraw_using_check(withdrawal_amount)
    end

    it "Outputs a warning if the account would go below -$10" do
      start_balance = 1000
      a = 2909
      proc {
        Bank::CheckingAccount.new(1879, start_balance).withdraw_using_check(a)
      }.must_output (/.+/)
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 1000
      a = -56
      proc {
        Bank::CheckingAccount.new(1879, start_balance).withdraw_using_check(a)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      balance = 100
      amount = 10
      account = Bank::CheckingAccount.new(17682, balance)
      3.times {balance = balance - amount}
      final_balance = 0
      3.times {final_balance = account.withdraw_using_check(amount)}

      final_balance.must_be_same_as balance
    end

    it "Applies a $2 fee after the third use" do
      balance = 100
      amount = 10
      fee = 2
      account = Bank::CheckingAccount.new(17682, balance)

      4.times {balance = balance - amount}
      balance -= fee
      final_balance = nil
      4.times {final_balance = account.withdraw_using_check(amount)}

      final_balance.must_equal balance
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      Bank::CheckingAccount.new(1819, 100).reset_checks
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      account = Bank::CheckingAccount.new(8282, 100)
      2.times {account.withdraw_using_check(10)}
      account.reset_checks
      3.times {account.withdraw_using_check(10)}
      account.balance.must_equal 50
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      account = Bank::CheckingAccount.new(8282, 100)
      4.times {account.withdraw_using_check(10)}
      account.reset_checks
      3.times {account.withdraw_using_check(10)}
      account.balance.must_equal 28
    end
  end
end
