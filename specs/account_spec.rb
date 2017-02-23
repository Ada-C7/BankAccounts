require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'
require 'csv'

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
      # Note: we haven't talked about procs yet. You can think
      # of them like blocks that sit by themselves.
      # This code checks that, when the proc is executed, it
      # raises an ArgumentError.
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

      # Another proc! This test expects something to be printed
      # to the terminal, using 'must_output'. /.+/ is a regular
      # expression matching one or more characters - as long as
      # anything at all is printed out the test will pass.
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
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

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do
    it "Returns an array" do
      accounts = Bank::Account.all
      accounts.must_be_instance_of Array
    end

    # handle empty array? or don't worry about that since checking in next test?
    it "Contains only Account elements in the returned array" do
      accounts = Bank::Account.all
      accounts.each do |account|
        account.must_be_instance_of Bank::Account # checks that each element within that array is an instance of the Account class
      end
    end

    it "Includes the correct number of accounts in the returned array" do
      accounts = Bank::Account.all
      num_of_accounts = CSV.read("support/accounts.csv").size
      accounts.length.must_equal num_of_accounts
    end

    it "Creates a first account with the csv's first listed ID and balance" do
      first_id = CSV.read("support/accounts.csv").first[0].to_i
      first_balance = CSV.read("support/accounts.csv").first[1].to_i
      accounts = Bank::Account.all

      accounts.first.id.must_equal first_id
      accounts.first.balance.must_equal first_balance
    end

    it "Creates a last account with the csv's last listed ID and balance" do
      last_id = CSV.read("support/accounts.csv").last[0].to_i
      last_balance = CSV.read("support/accounts.csv").last[1].to_i
      accounts = Bank::Account.all

      accounts.last.id.must_equal last_id
      accounts.last.balance.must_equal last_balance
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do # of Account class? or one of accounts in CSV file?
      skip
      # TODO: Your test code here!
    end

    it "Can find the first account from the CSV" do
      skip
      # TODO: Your test code here!
    end

    it "Can find the last account from the CSV" do
      skip
      # TODO: Your test code here!
    end

    it "Raises an error for an account that doesn't exist" do
      skip
      # TODO: Your test code here!
    end
  end
end
