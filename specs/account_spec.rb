require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'

#Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

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
      #If this raises an error, the test will fail. No 'must's needed!
      Bank::Account.new(1337, 0)
    end
  end

  describe "Account#withdraw" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance  - withdrawal_amount
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
      }.must_output(/.+/)
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


describe "Wave 2" do

  describe "Account.all" do
    it "Returns an array" do
      Bank::Account.reset_all_accounts_for_test
      Bank::Account.read_csv
      expect(Bank::Account.all).must_be_instance_of Array, "Not an array."
    end

    it "Returns an array consisting only of accounts" do
      Bank::Account.reset_all_accounts_for_test
      Bank::Account.read_csv
      Bank::Account.all.each do |account|
        account.must_be_instance_of Bank::Account, "Not an instance of Account class."
      end
    end

    it "Returns an array with the correct number of accounts" do
      Bank::Account.reset_all_accounts_for_test
      Bank::Account.read_csv
      expect(Bank::Account.all.length).must_equal 12, "Wrong number of accounts"
    end


    it "gives correct values for the ID and balance of the first and last
    accounts match what's in the CSV file" do
    Bank::Account.reset_all_accounts_for_test
    Bank::Account.read_csv
    expect(Bank::Account.all.first.id).must_equal 1212, "ID of first account is incorrect."
    Bank::Account.reset_all_accounts_for_test
    Bank::Account.read_csv
    expect(Bank::Account.all.first.balance).must_equal 12356.67, "ID of first account is incorrect."
    Bank::Account.reset_all_accounts_for_test
    Bank::Account.read_csv
    expect(Bank::Account.all.last.id).must_equal 15156, "ID of first account is incorrect."
    Bank::Account.reset_all_accounts_for_test
    Bank::Account.read_csv
    expect(Bank::Account.all.last.balance).must_equal 43567.72, "ID of first account is incorrect."
  end
end


describe "Account.find" do
  it "Returns an Account that exists" do
    Bank::Account.reset_all_accounts_for_test
    Bank::Account.read_csv
    expect(Bank::Account.find(15151)).must_be_instance_of Bank::Account, "Does not return account"
  end

  it "Can find the first account from the CSV" do
    Bank::Account.reset_all_accounts_for_test
    Bank::Account.read_csv
    expect(Bank::Account.find(1212)).must_equal Bank::Account.all.first, "Cannot find first account"
  end

  it "Can find the last account from the CSV" do
    Bank::Account.reset_all_accounts_for_test
    Bank::Account.read_csv
    expect(Bank::Account.find(15156)).must_equal Bank::Account.all.last, "Cannot find last account"
  end

  it "Raises an error for an account that doesn't exist" do
    Bank::Account.reset_all_accounts_for_test
    Bank::Account.read_csv
    proc {
      Bank::Account.find(9999999)
    }.must_raise ArgumentError
  end
end
end
