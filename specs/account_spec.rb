require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require "csv"
require_relative '../lib/account'

describe "Wave 1" do
  describe "Account#initialize" do
    it "Takes an ID and an initial balance" do
      id = 1337
      balance = 100.0
      open_date = "1/1/2017"
      account = Bank::Account.new(id, balance, open_date)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

      account.must_respond_to :open_date
      account.open_date.must_equal open_date
    end

    it "Raises an ArgumentError when created with a negative balance" do
      # Note: we haven't talked about procs yet. You can think
      # of them like blocks that sit by themselves.
      # This code checks that, when the proc is executed, it
      # raises an ArgumentError.
      proc {
        Bank::Account.new(1337, -100.0, "1/1/2017")
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      # If this raises, the test will fail. No 'must's needed!
      Bank::Account.new(1337, 0, "1/1/2017")
    end

    #Optional
    it "Uses default owner id of -1 when not given" do
      id = 1337
      balance = 100.0
      open_date = "1/1/2017"

      account = Bank::Account.new(id, balance, open_date)

      account.must_respond_to :owner_id
      account.owner_id.must_equal(-1)
    end

    #Optional
    it "Update owner_id" do
      id = 1337
      balance = 100.0
      open_date = "1/1/2017"
      owner_id = 101
      account = Bank::Account.new(id, balance, open_date)

      account.must_respond_to :owner_id
      account.owner_id = owner_id
      account.owner_id.must_equal owner_id
    end

    #Optional
    it "Creates an account with owner_id" do
      id = 1337
      balance = 100.0
      open_date = "1/1/2017"
      owner_id = 101
      account = Bank::Account.new(id, balance, open_date, owner_id)

      account.must_respond_to :owner_id
      account.owner_id.must_equal owner_id
    end
  end

  describe "Account#withdraw" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      open_date = '1/1/2017'
      account = Bank::Account.new(1337, start_balance, open_date)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      open_date = '1/1/2017'
      account = Bank::Account.new(1337, start_balance, open_date)

      updated_balance = account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      open_date = '1/1/2017'
      account = Bank::Account.new(1337, start_balance, open_date)

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
      open_date = '1/1/2017'
      account = Bank::Account.new(1337, start_balance, open_date)

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Allows the balance to go to 0" do
      account = Bank::Account.new(1337, 100.0, "1//1/2017")
      updated_balance = account.withdraw(account.balance)
      updated_balance.must_equal 0
      account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -25.0
      open_date = '1/1/2017'
      account = Bank::Account.new(1337, start_balance, open_date)

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do
    it "Increases the balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      open_date = "1/1/2017"
      account = Bank::Account.new(1337, start_balance, open_date)

      account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      open_date = "1/1/2017"
      account = Bank::Account.new(1337, start_balance, open_date)

      updated_balance = account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      start_balance = 100.0
      deposit_amount = -25.0
      open_date = "1/1/2017"
      account = Bank::Account.new(1337, start_balance, open_date)

      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end
  end
  #Optional
  describe "Owner#initialize" do
    it "Takes an ID, first name, last name, street address, city, and state" do
      #18,Gonzalez,Laura,310 Hauk Street,Springfield,Illinois
      id = 18
      name_first = "Laura"
      name_last = "Gonzalez"
      address_street = "310 Hauk Street"
      address_city = "Springfield"
      address_state = "Illinois"

      name = name_first + " " + name_last
      address = address_street + ", " + address_city + ", " + address_state

      owner = Bank::Owner.new(id, name_first, name_last, address_street, address_city, address_state)

      owner.must_respond_to :id
      owner.id.must_equal id

      owner.must_respond_to :name
      owner.name.must_equal name

      owner.must_respond_to :address
      owner.address.must_equal address
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do
    before do
      @all_accounts_array = Bank::Account.all
    end

    it "Check that class have a all method" do
      Bank::Account.must_respond_to :all
    end

    it "Returns an array of all accounts" do
      @all_accounts_array.must_be_kind_of Array
    end

    it "Everything in the array is an instance of Account class" do
      @all_accounts_array.each do |account_instance|
        account_instance.must_be_instance_of Bank::Account
      end
    end

    it "The number of accounts is correct = 12" do
      @all_accounts_array.length.must_equal 12
    end

    it "The ID and balance of the first account match what's in the CSV file" do
      test_id = 1212
      test_balance = 12356.67

      first_instance = @all_accounts_array.first
      first_instance.id.must_equal test_id
      first_instance.balance.must_equal test_balance
    end

    it "The ID and balance of the last account match what's in the CSV file" do
      test_id = 15156
      test_balance = 43567.72

      last_instance = @all_accounts_array.last
      last_instance.id.must_equal test_id
      last_instance.balance.must_equal test_balance
    end
  end

  describe "Account.find" do
    it "Check that class have a find method" do
      Bank::Account.must_respond_to :find
    end

    it "Returns an account that exists" do
      account_id = 15151
      #proc { Bank::Account.find(account_id) }.wont_raise ArgumentError
      Bank::Account.find(account_id).must_be_instance_of Bank::Account
    end

    it "Can find the first account from the CSV" do
      first_account_id = 1212
      #proc { Bank::Account.find(account_id) }.wont_raise ArgumentError
      Bank::Account.find(first_account_id).must_be_instance_of Bank::Account
    end

    it "Can find the last account from the CSV" do
      last_account_id = 15156
      #proc { Bank::Account.find(account_id) }.wont_raise ArgumentError
      Bank::Account.find(last_account_id).must_be_instance_of Bank::Account
    end

    it "Raises an error for an account that doesn't exist" do
      test_account_id = 9999
      proc { Bank::Account.find(test_account_id) }.must_raise ArgumentError
    end
  end

  describe "Owner.all" do
    before do
      @all_owners_array = Bank::Owner.all
    end

    it "Check that class have a all method" do
      Bank::Owner.must_respond_to :all
    end

    it "Returns an array of all owners" do
      @all_owners_array.must_be_kind_of Array
    end

    it "Everything in the array is an instance of Owner class" do
      @all_owners_array.each do |owner_instance|
        owner_instance.must_be_instance_of Bank::Owner
      end
    end

    it "The number of owners is correct = 12" do
      @all_owners_array.length.must_equal 12
    end

    it "The ID and balance of the first owner match what's in the CSV file" do
      #14,Morales,Wanda,9003 Gerald Hill,Honolulu,Hawaii
      test_id = 14
      test_name = "Wanda Morales"
      test_address = "9003 Gerald Hill, Honolulu, Hawaii"

      first_instance = @all_owners_array.first
      first_instance.must_respond_to :id
      first_instance.id.must_equal test_id
      first_instance.must_respond_to :name
      first_instance.name.must_equal test_name
      first_instance.must_respond_to :address
      first_instance.address.must_equal test_address
    end

    it "The ID and balance of the last owner match what's in the CSV file" do
      #25,Clark,Kathleen,72984 Chive Hill,New York City,New York
      test_id = 25
      test_name = "Kathleen Clark"
      test_address = "72984 Chive Hill, New York City, New York"

      last_instance = @all_owners_array.last
      last_instance.must_respond_to :id
      last_instance.id.must_equal test_id
      last_instance.must_respond_to :name
      last_instance.name.must_equal test_name
      last_instance.must_respond_to :address
      last_instance.address.must_equal test_address
    end
  end

  describe "Owner.find" do
    it "Check that class have a find method" do
      Bank::Owner.must_respond_to :find
    end

    it "Returns an owner that exists" do
      owner_id = 19
      Bank::Owner.find(owner_id).must_be_instance_of Bank::Owner
    end

    it "Can find the first owner from the CSV" do
      first_owner_id = 14
      Bank::Owner.find(first_owner_id).must_be_instance_of Bank::Owner
    end

    it "Can find the last owner from the CSV" do
      last_owner_id = 14
      Bank::Owner.find(last_owner_id).must_be_instance_of Bank::Owner
    end

    it "Raises an error for an owner that doesn't exist" do
      test_owner_id = 9999
      proc { Bank::Owner.find(test_owner_id) }.must_raise ArgumentError
    end
  end
  
end
