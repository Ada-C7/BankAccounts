require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'
require 'csv'
require 'date'

Minitest::Reporters.use!

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

      # Another proc! This test expects something to be printed
      # to the terminal, using 'must_output'. /.+/ is a regular
      # expression matching one or more characters - as long as
      # anything at all is printed out the test will pass.
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
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
# Added a block to test add_owner method:
  describe "Account#add_owner" do
    it "Must be created, account owner must be type of Bank::Owner" do
      account = Bank::Account.new(2323, 300)
      account.add_owner(12, "Kuleniuk")
      account.owner.must_be_kind_of Bank::Owner
      account.owner.wont_be_nil
    end
  end
end

describe "Wave 2" do
  describe "Account.all" do
    it "Account.all returns an array" do
      Bank::Account.all.must_be_kind_of Array
    end
    it "Everything in the array is an Account" do
      all_accounts = Bank::Account.all
      all_accounts.each do |account|
        account.must_be_kind_of Bank::Account
      end
    end
    it " The number of accounts is correct" do
      all_accounts = Bank::Account.all
      all_accounts.length.must_be :==, 12
    end
    it " - The ID and balance of the first and last
          accounts match what's in the CSV file" do
      csv = CSV.read("support/accounts.csv", 'r')
      expected_id_first = csv[0][0].to_i
      expected_balance_first = csv[0][1].to_i/100.0
      expected_id_last = csv[11][0].to_i
      expected_balance_last = csv[11][1].to_i/100.0
      all_accounts = Bank::Account.all
      all_accounts[0].id.must_equal expected_id_first
      all_accounts[0].balance.must_equal expected_balance_first
      all_accounts[11].id.must_equal expected_id_last
      all_accounts[11].balance.must_equal expected_balance_last
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      result = Bank::Account.find(1213)
      result.must_be_kind_of Bank::Account
      # Can't figure out why next line does not work:
      # I assume it is connected with the fact that
      # object references are different in result and
      # in all_accounts
      # all_accounts = Bank::Account.all
      # all_accounts.must_include result
    end

    it "Can find the first account from the CSV" do
      csv = CSV.read("support/accounts.csv", 'r')
      result = Bank::Account.find(csv[0][0].to_i)
      result.id.must_be :==, Bank::Account.all[0].id
      result.balance.must_be :==, Bank::Account.all[0].balance
      result.date_created.must_be :==, Bank::Account.all[0].date_created
    end

    it "Can find the last account from the CSV" do
      csv = CSV.read("support/accounts.csv", 'r')
      result = Bank::Account.find(csv[11][0].to_i)
      result.id.must_be :==, Bank::Account.all[11].id
      result.balance.must_be :==, Bank::Account.all[11].balance
      result.date_created.must_be :==, Bank::Account.all[11].date_created
    end

    it "Raises an error for an account that doesn't exist" do
      proc {
        Bank::Account.find(100000)
      }.must_raise ArgumentError
    end
  end

 end
