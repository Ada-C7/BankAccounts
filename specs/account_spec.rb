require 'csv'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Wave 1" do
  describe "Account#initialize" do
    it "Takes an ID and an initial balance" do
      id = 1337
      balance = 100.0
      account = Bank::Account.new(id, balance)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance
    end

    it "Raises an ArgumentError when created with a negative balance" do
      proc {
        Bank::Account.new(1337, -100.0)
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      # If this raises, the test will fail. No 'must's needed!
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
      }.must_output /.+/
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

    before do
      @accounts = Bank::Account.all
    end

    it "Returns an array of all accounts" do
      @accounts.must_be_instance_of Array
    end
    it "Everything in the array is an Account" do
      @accounts.each do |account|
        account.must_be_instance_of Bank::Account
      end
    end
    it "Number of accounts is correct" do
      @accounts.length.must_equal 12
    end

    it "Match elements in file" do
      CSV.read('support/accounts.csv') do |line|
        counter = 0
        @accounts[counter].id.must_equal line[0].to_i
        @accounts[counter].balance.must_equal line[1].to_i
        counter += 1
      end
    end

      it "ID and balance match the first and last element" do
        @accounts.first.id.must_equal 1212
        @accounts.first.balance.must_equal 1235667

        @accounts.last.id.must_equal 15156
        @accounts.last.balance.must_equal 4356772
      end
    end


  describe "Account.find" do
    it "Returns an account that exists" do
      account = Bank::Account.find(1216)

      account.must_be_instance_of Bank::Account
      account.id.must_equal 1216
      account.balance.must_equal 100022
    end

    it "Can find the first account from the CSV" do
      account = Bank::Account.find(1212)

       account.must_be_instance_of Bank::Account
       account.id.must_equal 1212
       account.balance.must_equal 1235667
    end

    it "Can find the last account from the CSV" do
      account = Bank::Account.find(15156)

       account.must_be_instance_of Bank::Account
       account.id.must_equal 15156
       account.balance.must_equal 4356772
    end

    it "Raises an error for an account that doesn't exist" do
      proc {
        Bank::Account.find(666)
      }.must_raise ArgumentError
    end
  end
end
