require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'
require_relative '../lib/account'


describe "CheckingAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      new_balance = checking_account.withdraw(10)
      new_balance.must_equal 189
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      proc { checking_account.withdraw(200)}.must_output(/.+/)
      checking_account.balance.must_equal 200
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      checking_account.balance.must_equal 200
      checking_account.withdraw_with_check(10)
      checking_account.balance.must_equal 190
    end

    it "Returns the modified balance" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      checking_account.balance.must_equal 200
      checking_account.withdraw_with_check(10)
      checking_account.balance.must_equal 190
    end

    it "Allows the balance to go down to -$10" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      checking_account.withdraw_with_check(210)
      checking_account.balance.must_equal(-10)
    end

    it "Outputs a warning if the account would go below -$10" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      checking_account.withdraw_with_check(211)
      checking_account.balance.must_equal 200

      proc { checking_account.withdraw_with_check(211)}.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      checking_account.withdraw_with_check(211)
      checking_account.balance.must_equal 200
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -25.0
      checking_account = Bank::CheckingAccount.new(11, start_balance)

      proc {
        checking_account.withdraw_with_check(withdrawal_amount)
      }.must_raise(ArgumentError)
    end

    it "Allows 3 free uses" do
      checking_account = Bank::CheckingAccount.new(11, 80)

      3.times do checking_account.withdraw_with_check(20)
      end
      checking_account.balance.must_equal 20
    end

    it "Applies a $2 fee after the third use" do
      checking_account = Bank::CheckingAccount.new(11, 100)

      4.times do checking_account.withdraw_with_check(20)
      end
      checking_account.balance.must_equal 18
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      4.times do checking_account.withdraw_with_check(20)
      end
      checking_account.reset_checks
      checking_account.withdraw_with_check(20)
      checking_account.balance.must_equal 98
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      3.times do checking_account.withdraw_with_check(20)
      end
      checking_account.balance.must_equal 140
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      checking_account = Bank::CheckingAccount.new(11, 200)

      4.times do checking_account.withdraw_with_check(20)
      end
      checking_account.reset_checks
      checking_account.withdraw_with_check(20)
      checking_account.balance.must_equal 98
    end
  end
end
