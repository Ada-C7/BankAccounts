require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'
require_relative '../lib/owner'

describe "Wave 1" do
  describe "Account#initialize" do
    it "Takes an ID and an initial balance without owner parameter" do
      id = 1337
      balance = 100
      account = Bank::Account.new(id: id, balance: balance)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

      account.must_respond_to :owner
      account.owner.must_be_nil
    end

    it "Takes an ID, initial balance, owner, and open date" do
      id = 1337
      balance = 100
      owner = Bank::Owner.new(id: 12345, first_name: "Alix")
      open_date = "1994-11-17 14:04:56 -0800"
      account = Bank::Account.new(id: id, balance: balance, owner: owner, open_date: open_date)

      account.must_respond_to :owner
      account.owner.must_equal owner

      # Account attribute classes match schema data types
      account.id.must_be_instance_of Integer
      account.balance.must_be_instance_of Float
      account.open_date.must_be_instance_of DateTime

      # Appropriately handles open_date as DateTime object
      account.open_date.year.must_equal 1994
    end

    it "Raises an ArgumentError when created with a negative balance" do
      # Note: we haven't talked about procs yet. You can think
      # of them like blocks that sit by themselves.
      # This code checks that, when the proc is executed, it
      # raises an ArgumentError.
      proc {
        Bank::Account.new(id: 1337, balance: -100)
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      # If this raises, the test will fail. No 'must's needed!
      Bank::Account.new(id: 1337, balance: 0)
    end
  end

  describe "Account#withdraw" do
    before do
      @account = Bank::Account.new(id: 1337, balance: 100)
      @start_balance = @account.balance
    end

    it "Reduces the balance" do
      withdrawal_amount = 25

      @account.withdraw(withdrawal_amount)

      expected_balance = @start_balance - withdrawal_amount
      @account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      withdrawal_amount = 25

      updated_balance = @account.withdraw(withdrawal_amount)

      expected_balance = @start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative and doesn't modify balance" do
      withdrawal_amount = 200

      # Must print out error to the terminal
      proc {
        @account.withdraw(withdrawal_amount)
      }.must_output(/.+/)

      # Must not update balance
      @account.balance.must_equal @start_balance
    end

    it "Allows the balance to go to 0" do
      updated_balance = @account.withdraw(@account.balance)
      updated_balance.must_equal 0
      @account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      withdrawal_amount = -25

      proc {
        @account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do
    it "Increases the balance" do
      start_balance = 100
      deposit_amount = 25
      account = Bank::Account.new(id: 1337, balance: start_balance)

      account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100
      deposit_amount = 25
      account = Bank::Account.new(id: 1337, balance: start_balance)

      updated_balance = account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      start_balance = 100
      deposit_amount = -25
      account = Bank::Account.new(id: 1337, balance: start_balance)

      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#add_owner" do
    it "Adds a new owner when the current owner is nil" do
      id = 1337
      balance = 100
      owner = Bank::Owner.new(id: 12345, first_name: "Alix")

      account = Bank::Account.new(id: id, balance: balance)
      account.add_owner(owner)

      account.owner.first_name.must_equal owner.first_name
    end

    it "Does not add a new owner when it is already set" do
      id = 1337
      balance = 100
      owner = Bank::Owner.new(id: 12345, first_name: "Alix")
      account = Bank::Account.new(id: id, balance: balance, owner: owner)

      another_owner = Bank::Owner.new(id: 12334, first_name: "Hamlet")

      proc {
        account.add_owner(another_owner)
      }.must_raise ArgumentError

      account.owner.first_name.must_equal owner.first_name
    end
  end
end

describe "Wave 2" do
  describe "Account.all" do
    before do
      @accounts = Bank::Account.all
    end

    it "Returns an array of all accounts" do
      # Account.all returns an array
      @accounts.must_be_instance_of Array
    end

    it "All items in returned array are Account instances" do
      @accounts.each { |account| account.must_be_instance_of Bank::Account }
    end

    it "Returns the correct number of accounts" do
      number_of_accounts = CSV.read("support/accounts.csv").count
      @accounts.length.must_equal number_of_accounts
    end

    it "Returns a complete array of accounts from the csv file" do
      # The ID and balance of the first and last
      # accounts match what's in the CSV file
      first_account = CSV.read("support/accounts.csv").first
      @accounts[0].id.must_equal first_account[0].to_i
      @accounts[0].balance.must_equal first_account[1].to_f/100

      last_account = CSV.read("support/accounts.csv").last
      @accounts[-1].id.must_equal last_account[0].to_i
      @accounts[-1].balance.must_equal last_account[1].to_f/100
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      found_account = Bank::Account.find(1214)

      found_account.must_be_instance_of Bank::Account
      found_account.balance.must_equal 98768.90
    end

    it "Can find the first account from the CSV" do
      first_account = CSV.read("support/accounts.csv").first
      first_account_id = first_account[0].to_i
      first_account_balance = first_account[1].to_f/100
      found_account = Bank::Account.find(first_account_id)

      found_account.id.must_equal first_account_id
      found_account.balance.must_equal first_account_balance
    end

    it "Can find the last account from the CSV" do
      last_account = CSV.read("support/accounts.csv").last
      last_account_id = last_account[0].to_i
      last_account_balance = last_account[1].to_f/100
      found_account = Bank::Account.find(last_account_id)

      found_account.id.must_equal last_account_id
      found_account.balance.must_equal last_account_balance
    end

    it "Raises an error for an account that doesn't exist" do
      proc {
        Bank::Account.find("HAMBURGLER")
      }.must_raise ArgumentError
    end
  end
end
