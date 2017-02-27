require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checkingaccount'
require 'date'



# TODO: change 'xdescribe' to 'describe' to run these tests

describe "#initialize" do
  # Check that a CheckingAccount is in fact a kind of account
  it "Is a kind of Account" do
    account = Bank::CheckingAccount.new(12345, 100.0)
    account.must_be_kind_of Bank::Account
  end
end

describe "#withdraw" do
  it "Applies a $1 fee each time" do
    opening_balance = 100
    withdrawal_amount = 90
    total_withdrawl = withdrawal_amount + 1
    account = Bank::CheckingAccount.new(12345,opening_balance)
    account.withdraw(withdrawal_amount).must_equal opening_balance - total_withdrawl

  end
  it "Doesn't modify the balance if the fee would put it negative" do
    opening_balance = 100
    withdrawal_amount = 111

    account = Bank::CheckingAccount.new(12345,opening_balance)
    account.withdraw(withdrawal_amount).must_equal opening_balance
  end
end


describe "#withdraw_using_check" do
  it "Reduces the balance" do
    opening_balance = 100
    withdrawal_amount = 10

    account = Bank::CheckingAccount.new(12345, opening_balance)
    account.withdraw_using_check(withdrawal_amount).wont_equal opening_balance
  end

  it "Returns the modified balance" do
    opening_balance = 100
    withdrawal_amount = 10
    account = Bank::CheckingAccount.new(12345, opening_balance)
    3.times{account.withdraw_using_check(10)}
    account.withdraw_using_check(1)
    new_balance = account.balance

    if account.count <= 3
      account.withdraw_using_check(withdrawal_amount).must_equal new_balance - withdrawal_amount
    elsif account.count >= 4
      account.withdraw_using_check(withdrawal_amount).must_equal new_balance - (withdrawal_amount + 2)
    end
  end

  it "Allows the balance to go down to -$10" do
    opening_balance = 100
    withdrawal_amount = 109
    account = Bank::CheckingAccount.new(12345, opening_balance)
    account.withdraw_using_check(withdrawal_amount).must_equal opening_balance - withdrawal_amount
  end

  it "Outputs a warning if the account would go below -$10" do
    start_balance = 100.0
    withdrawal_amount = 111.0
    account = Bank::CheckingAccount.new(1337, start_balance)
    #This is a proc with a regex that requires a string in order for the test to pass
    proc {
      account.withdraw_using_check(withdrawal_amount)
    }.must_output (/.+/)
  end

  it "Doesn't modify the balance if the account would go below -$10" do
    start_balance = 100.0
    withdrawal_amount = 111.0
    account = Bank::CheckingAccount.new(1337, start_balance)
    account.withdraw_using_check(withdrawal_amount).must_equal start_balance
  end

  it "Requires a positive withdrawal amount" do
    start_balance = 100.0
    withdrawal_amount = -111.0
    account = Bank::CheckingAccount.new(1337, start_balance)
    # This is a proc with a rexex that requires a string in order for the test to passed
    proc {
      account.withdraw_using_check(withdrawal_amount)
    }.must_raise ArgumentError
  end

  it "Allows 3 free uses" do
    opening_balance = 100
    withdrawal_amount = 10
    account = Bank::CheckingAccount.new(12345, opening_balance)
    3.times{account.withdraw_using_check(10)}
    new_balance = account.balance

    if account.count <= 3
      account.withdraw_using_check(withdrawal_amount).must_equal new_balance - withdrawal_amount
    end
  end

  it "Applies a $2 fee after the third use" do
    opening_balance = 100
    withdrawal_amount = 10
    account = Bank::CheckingAccount.new(12345, opening_balance)
    4.times{account.withdraw_using_check(10)}
    new_balance = account.balance

    if account.count <= 3
      account.withdraw_using_check(withdrawal_amount).must_equal new_balance - (withdrawal_amount + 2)
    end
  end
end


describe "#reset_checks" do
  it "Can be called without error" do
    account = Bank::CheckingAccount.new(1234, 1000)
  end


it "Makes the next three checks free if less than 3 checks had been used" do
  opening_balance = 100
  withdrawal_amount = 10
  account = Bank::CheckingAccount.new(12345, opening_balance)
  2.times{account.withdraw_using_check(10)}
  new_balance = account.balance
  account.reset_checks

  if account.count <= 3
    account.withdraw_using_check(withdrawal_amount).must_equal new_balance - (withdrawal_amount)
  end
end

it "Makes the next three checks free if more than 3 checks had been used" do 
  opening_balance = 100
  withdrawal_amount = 10
  account = Bank::CheckingAccount.new(12345, opening_balance)
  4.times{account.withdraw_using_check(10)}
  new_balance = account.balance
  account.reset_checks

  if account.count <= 3
    account.withdraw_using_check(withdrawal_amount).must_equal new_balance - (withdrawal_amount)
  end
end
end
