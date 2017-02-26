require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # skip
      account = Bank::MoneyMarketAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      # skip
      start_balance = 100.0
      withdraw_amount = 50.0
      account = Bank::MoneyMarketAccount.new(666, start_balance)

      account.withdraw(withdraw_amount)

      expected_balance = start_balance - withdraw_amount - 1
      account.balance.must_equal expected_balance
    end

    it "Doesn't modify the balance if the fee would put negative" do
      # skip
      start_balance = 10.0
      withdraw_amount = 10.0
      account = Bank::MoneyMarketAccount.new(666, start_balance)

      account.withdraw(withdraw_amount)

      expected_balance = start_balance - withdraw_amount - 1
      account.balance.must_equal start_balance
    end
  end

  describe "#withdraw_using_check" do
    it "Reduces the balance" do
      # skip
      start_balance = 100.0
      check_withdraw_amount = 50.0
      account = Bank::MoneyMarketAccount.new(666, start_balance)

      account.withdraw_using_check(check_withdraw_amount)

      expected_balance = start_balance - check_withdraw_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      # skip
      start_balance = 100.0
      check_withdraw_amount = 50.0
      account = Bank::MoneyMarketAccount.new(666, start_balance)

      account.withdraw_using_check(check_withdraw_amount)

      expected_balance = start_balance - check_withdraw_amount
      account.balance.must_equal expected_balance
    end

    it "Allows the balance to go down to -$10" do
      # skip
      start_balance = 100.0
      check_withdraw_amount = 110.0
      account = Bank::MoneyMarketAccount.new(666, start_balance)

      account.withdraw_using_check(check_withdraw_amount)

      expected_balance = start_balance - check_withdraw_amount
      account.balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go below -$10" do
      # skip
      proc {
        Bank::MoneyMarketAccount.new(666, -11)
      }.must_raise ArgumentError
    end

    it "Doesn't modify the balance if the account would go below -$10" do
      # skip
      start_balance = 100.0
      check_withdraw_amount = 111.0
      account = Bank::MoneyMarketAccount.new(666, start_balance)

      account.withdraw_using_check(check_withdraw_amount)

      # expected_balance = start_balance - check_withdraw_amount
      account.balance.must_equal start_balance
    end

    it "Requires a positive withdrawal amount" do
      # skip
      start_balance = 100.0
      withdrawal_amount = -50.0
      account = Bank::MoneyMarketAccount.new(666, start_balance)

      proc {
        account.withdraw_using_check(withdrawal_amount)
      }.must_raise ArgumentError
    end

    it "Allows 3 free uses" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 2.0
      account = Bank::MoneyMarketAccount.new(666, start_balance)

      3.times do
        account.withdraw_using_check(withdrawal_amount)
      end

      expected_balance = start_balance - (3 * withdrawal_amount)

      account.balance.must_equal expected_balance
    end

    it "Applies a $2 fee after the third use" do
      skip
      # TODO: Your test code here!
    end
  end

  describe "#reset_checks" do
    it "Can be called without error" do
      skip
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      skip
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      skip
      # TODO: Your test code here!
    end
  end
end
