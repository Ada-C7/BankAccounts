require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'

describe "Wave 1" do

  describe "Account#initialize" do
    it "Takes an ID and an initial balance and a date" do
      id = 1337
      balance = 100.0
      date = nil
      account = Bank::Account.new(id, balance, date)
      account.must_respond_to :id
      account.id.must_equal id
      account.must_respond_to :balance
      account.balance.must_equal balance
      account.must_respond_to :date
      account.date.must_equal date
    end

    it "Raises an ArgumentError when created with a negative balance" do
      proc {
        Bank::Account.new(1337, -100.0)
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      Bank::Account.new(1337, 0)
    end
  end

  describe "Account#withdraw" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance)
      account.withdraw(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance)
      updated_balance = account.withdraw(withdrawal_amount)
      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance)
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance)
      updated_balance = account.withdraw(withdrawal_amount)
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Allows the balance to go to 0" do
      account = Bank::Account.new(1337, 100.0)
      updated_balance = account.withdraw(account.balance)
      updated_balance.must_equal 0
      account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -25.0
      account = Bank::Account.new(1337, start_balance)
      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do
    it "Increases the balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance)
      account.deposit(deposit_amount)
      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance)
      updated_balance = account.deposit(deposit_amount)
      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      start_balance = 100.0
      deposit_amount = -25.0
      account = Bank::Account.new(1337, start_balance)
      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end
  end

end


describe "Wave 2" do

  describe "Account.all" do
    it "Returns an array of all accounts" do
      Bank::Account.all.must_be_instance_of Array, "Not an array"
    end

    it "Everything in the array is an Account" do
      Bank::Account.all.each do |account|
        account.must_be_instance_of Bank::Account, "Not instance of Account Class"
      end

      it "The number of accounts is correct" do
        Bank::Account.all.length.must_equal 12
      end

      it "Id and Balance of first and last account match" do
        Bank::Account.all[0].id.must_equal(1212)
        Bank::Account.all[0].balance.must_equal(1235667)
        Bank::Account.all[-1].id.must_equal(15156)
        Bank::Account.all[-1].balance.must_equal(4356772)
      end
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      Bank::Account.find(1217)
    end

    it "Can find the first account from the CSV" do
      Bank::Account.find(1212)
      # Bank::Account.all.must_match(Bank::Account.find(Array))
    end

    it "Can find the last account from the CSV" do
      Bank::Account.find(15156)
    end

    it "Raises an error for an account that doesn't exist" do
      proc{
        Bank::Account.find(98387584)
      }.must_raise ArgumentError
    end
  end

end
