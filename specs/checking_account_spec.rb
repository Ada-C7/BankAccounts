require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'



# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

describe "CheckingAccount" do
  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      account = Bank::CheckingAccount.new(12345, 100.0,"NA")
      account.must_be_kind_of Bank::Account
    end
  end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      start_balance = 1399
      withdrawal_amount = 100
      account = Bank::CheckingAccount.new(1337, start_balance, "NA")

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal (start_balance - 100 - withdrawal_amount)
      account.balance.must_equal (start_balance - 100-withdrawal_amount)
    end
  end

  it "Doesn't modify the balance if the fee would put it negative" do
    start_balance = 1399
    withdrawal_amount = 1300
    account = Bank::CheckingAccount.new(1337, start_balance, "NA")

    updated_balance = account.withdraw(withdrawal_amount)

    # Both the value returned and the balance in the account
    # must be un-modified.
    updated_balance.must_equal start_balance
    account.balance.must_equal start_balance

  end
end

describe "#withdraw_using_check" do
  it "Reduces the balance" do
    start_balance = 1399
    withdrawal_amount = 1300
    account = Bank::CheckingAccount.new(1337, start_balance, "NA")

    updated_balance = account.withdraw_using_check(withdrawal_amount)

    # Both the value returned and the balance in the account
    # must be un-modified.
    (updated_balance - start_balance).wont_equal
    ((updated_balance - start_balance).abs)
  end

  it "Returns the modified balance" do
    start_balance = 1400
    withdrawal_amount = 1300
    account = Bank::CheckingAccount.new(1337, start_balance, "NA")
    updated_balance = account.withdraw_using_check(withdrawal_amount)

    expected_balance = start_balance - withdrawal_amount

    updated_balance.must_equal expected_balance #account.balance.must_equal expected_balance

  end

  it "Allows the balance to go down to -$10" do
    start_balance = 1400
    withdrawal_amount = 1410
    account = Bank::CheckingAccount.new(1337, start_balance, "NA")
    updated_balance = account.withdraw_using_check(withdrawal_amount)

    expected_balance = start_balance - withdrawal_amount

    updated_balance.must_equal expected_balance #account.balance.must_equal expected_balance
  end

  it "Outputs a warning if the account would go below -$10" do
    start_balance = 1000
    withdrawal_amount = 3000
    account = Bank::CheckingAccount.new(1337, start_balance,"BA")
    # Another proc! This test expects something to be printed
    # to the terminal, using 'must_output'. /.+/ is a regular
    # expression matching one or more characters - as long as
    # anything at all is printed out the test will pass.
    proc {
      account.withdraw_using_check(withdrawal_amount)
    }.must_output /.+/
  end

  it "Doesn't modify the balance if the account would go below -$10" do
    start_balance = 10000
    withdrawal_amount = 20001
    account = Bank::CheckingAccount.new(1337, start_balance, "NA")

    updated_balance = account.withdraw_using_check(withdrawal_amount)

    # Both the value returned and the balance in the account
    # must be un-modified.
    updated_balance.must_equal start_balance
    account.balance.must_equal start_balance

  end

  it "Requires a positive withdrawal amount" do
    start_balance = 10000
    withdrawal_amount = 0
    account = Bank::CheckingAccount.new(1337, start_balance, "NA")

    proc {
      account.withdraw_using_check(withdrawal_amount)
    }.must_raise ArgumentError
  end

  it "Allows 3 free uses" do
    start_balance = 10000
    withdrawal_amount = 2000

    account = Bank::CheckingAccount.new(1337, start_balance, "NA")


    3.times {account.withdraw_using_check(withdrawal_amount)}
    updated_balance = account.balance

    expected_balance = start_balance - 3 * withdrawal_amount

    updated_balance.must_equal expected_balance
  end

  it "Applies a $2 fee after the third use" do
    start_balance = 10000
    withdrawal_amount = 2000

    account = Bank::CheckingAccount.new(1337, start_balance, "NA")


    4.times {account.withdraw_using_check(withdrawal_amount)}
    updated_balance = account.balance

    expected_balance = start_balance - 4 * withdrawal_amount - 200

    updated_balance.must_equal expected_balance
  end
end

describe "#reset_checks" do
  it "Can be called without error" do
    start_balance = 1000000
    account = Bank::CheckingAccount.new(1337, start_balance, "NA")
    account.reset_checks
  end

  it "Makes the next three checks free if less than 3 checks had been used" do

    start_balance = 10000
    withdrawal_amount = 100

    account = Bank::CheckingAccount.new(1337, start_balance, "NA")


    2.times {account.withdraw_using_check(withdrawal_amount)}

    expected_balance = start_balance - 2 * withdrawal_amount

    account.reset_checks


    3.times {account.withdraw_using_check(withdrawal_amount)}

    expected_balance = expected_balance - 3 * withdrawal_amount

    updated_balance = account.balance


    updated_balance.must_equal expected_balance


  end

  it "Makes the next three checks free if more than 3 checks had been used" do
    start_balance = 10000
    withdrawal_amount = 100

    account = Bank::CheckingAccount.new(1337, start_balance, "NA")


    4.times {account.withdraw_using_check(withdrawal_amount)}

    expected_balance = start_balance - 4 * withdrawal_amount - 200

    account.reset_checks


    3.times {account.withdraw_using_check(withdrawal_amount)}

    expected_balance = expected_balance - 3 * withdrawal_amount

    updated_balance = account.balance


    updated_balance.must_equal expected_balance

  end
end
