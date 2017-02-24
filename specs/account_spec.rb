require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'CSV'
require_relative '../lib/account'

# wave 1 tests
describe "Wave 1" do

  # tests for the Account initialize method
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
      Bank::Account.new(1337, 0)
    end
  end

  # tests for the Account withdrawal method
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

      proc { account.withdraw(withdrawal_amount) }.must_output(/.+/)
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

  # tests for the Account deposit method
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

  # describe "Owner#initialze" do
  #   it "requires a first name, last name, and address" do
  #     first_name = "Kelsey"
  #     last_name = "McAlpine"
  #     address = "554 Somewhere Street"
  #     owner = Bank::Owner.new(first_name, last_name, address)
  #
  #     owner.must_respond_to :first_name
  #     owner.first_name.must_equal first_name
  #
  #     owner.must_respond_to :last_name
  #     owner.last_name.must_equal last_name
  #
  #     owner.must_respond_to :address
  #     owner.address.must_equal address
  #   end
  # end
end

# wave 2 tests
describe "Wave 2" do

  # tests for the the Account.all method
  describe "Account.all" do

    before do
      @all_accounts = Bank::Account.all
    end

    it "Returns an array of all accounts" do
      @all_accounts.must_be_instance_of Array
    end

    it "Everything in the array is an Account" do
      @all_accounts.each do |account|
        account.must_be_instance_of Bank::Account
      end
    end

    it "The number of accounts is correct" do
      @all_accounts.length.must_equal 12
    end

    it "the ID and balance of the first and last accounts match the CSV file" do
      @all_accounts.first.id.must_equal 1212
      @all_accounts.first.balance.must_equal 1235667
      @all_accounts.last.id.must_equal 15156
      @all_accounts.last.balance.must_equal 4356772
    end

    it "The elements match what's in the file" do
      index = 0
      CSV.read("support/accounts.csv") do |line|

        @all_accounts[index].id.must_equal line[0].to_i
        @all_accounts[index].balance.must_equal line[1].to_i
        @all_accounts[index].open_date.must_equal line[2]
        index += 1
      end
    end
  end

  # tests for the Account.find method
  describe "Account.find" do
    it "Returns an account that exists" do
      account = Bank::Account.find(1216)
      account.must_be_instance_of Bank::Account
      account.id.must_equal 1216
      account.balance.must_equal 100022
      account.open_date.must_equal "2000-07-07 15:07:55 -0800"
    end

    it "Can find the first account from the CSV" do
      account = Bank::Account.find(1212)
      account.must_be_instance_of Bank::Account
      account.id.must_equal 1212
      account.balance.must_equal 1235667
      account.open_date.must_equal "1999-03-27 11:30:09 -0800"
    end

    it "Can find the last account from the CSV" do
      account = Bank::Account.find(15156)
      account.must_be_instance_of Bank::Account
      account.id.must_equal 15156
      account.balance.must_equal 4356772
      account.open_date.must_equal "1994-11-17 14:04:56 -0800"
    end

    it "Raises an error for an account that doesn't exist" do
      proc { Bank::Account.find(000) }.must_raise ArgumentError
    end
  end
end
