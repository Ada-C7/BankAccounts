require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'time'
require_relative '../lib/account'


describe "Wave 1" do
  describe "Account#initialize" do
    it "Takes an ID and an initial balance" do
      id = 1337
      balance = 100.0
      opendate = "1999-03-27 11:30:09 -0800"
      account = Bank::Account.new(id, balance, opendate)

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
        Bank::Account.new(1337, -100.0, "1999-03-27 11:30:09 -0800")
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
    # If this raises, the test will fail. No 'must's needed!
      Bank::Account.new(1337, 0, "1999-03-27 11:30:09 -0800")
    end
  end

  describe "Account#withdraw" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

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
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Allows the balance to go to 0" do
      account = Bank::Account.new(1337, 100.0, "1999-03-27 11:30:09 -0800")
      updated_balance = account.withdraw(account.balance)
      updated_balance.must_equal 0
      account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do
    it "Increases the balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      start_balance = 100.0
      deposit_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end
  end
end

# TESTS FOR WAVE2 BY TAMIKO TERADA
describe "Wave 2" do
  describe "Account.all" do
    it "Account.all returns an array" do
      all_accounts = Bank::Account.all
      all_accounts.must_be_kind_of Array
    end

    it "Everything in the array is an Account" do
      all_accounts = Bank::Account.all
      all_accounts.each do |instance| # each loop to check all items
        instance.must_be_kind_of Bank::Account
      end
    end

    it "The number of accounts is correct" do
      expected_rows = 12 # must be changed with different CSV
      all_accounts = Bank::Account.all
      all_accounts.length.must_equal expected_rows
    end

    it "ID + balance of first/last accounts match .csv" do
      all_accounts = Bank::Account.all
      expected_first_id = 1212
      expected_last_id = 15156
      all_accounts.first.id.must_equal expected_first_id
      all_accounts.last.id.must_equal expected_last_id
      expected_first_balance = 12356.67
      expected_last_balance = 43567.72
      all_accounts.first.balance.must_equal expected_first_balance
      all_accounts.last.balance.must_equal expected_last_balance
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      get_id = 1212
      found_account = Bank::Account.find(get_id)
      expected_id = get_id
      expected_balance = 12356.67
      expected_date = Time.parse("1999-03-27 11:30:09 -0800")
      found_account.id.must_equal expected_id
      found_account.balance.must_equal expected_balance
      found_account.opendate.must_equal expected_date
    end

    it "Can find the first account from the CSV" do
      get_id = 15151
      found_account = Bank::Account.find(get_id)
      expected_id = get_id
      expected_balance = 98445.67
      expected_date = Time.parse("1993-01-17 13:30:56 -0800")
      found_account.id.must_equal expected_id
      found_account.balance.must_equal expected_balance
      found_account.opendate.must_equal expected_date
    end

    it "Can find the last account from the CSV" do
      get_id = 15156
      found_account = Bank::Account.find(get_id)
      expected_id = get_id
      expected_balance = 43567.72
      expected_date = Time.parse("1994-11-17 14:04:56 -0800")
      found_account.id.must_equal expected_id
      found_account.balance.must_equal expected_balance
      found_account.opendate.must_equal expected_date
    end

    it "Raises an error for an account that doesn't exist" do
      proc {
        Bank::Account.find(666) # non-existent account number
      }.must_raise ArgumentError
    end
  end
end
