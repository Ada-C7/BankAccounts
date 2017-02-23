require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/account_wave_2'

describe "Wave 1" do



  # Add an owner property to each Account to track information about who owns the account.
  describe "Owner#initialize" do
    it "Takes a name and an address" do
      name = "George Franklin"
      address = "102 4th Ave West, Seattle, WA, 98110"
      owner = Bank::Owner.new(name, address)

      owner.must_respond_to :name
      owner.name.must_equal name

      owner.must_respond_to :address
      owner.address.must_equal address
    end
  end
# The Account can be created with an owner, OR you can create a method that will add the owner after the Account has already been created.


  describe "Account#initialize" do

    it "Takes an ID and an initial balance, and an owner" do
      id = 1337
      balance = 100.0
      open_date = "Jan 2"
      new_owner = Bank::Owner.new("George", "101 South 1st")
      account = Bank::Account.new(id, balance, open_date, new_owner)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

      account.must_respond_to :open_date
      account.open_date.must_equal open_date

      account.must_respond_to :owner
      account.owner.must_equal new_owner
    end

    # potentially unnecessary/redundant test
    it "owner name and address from within account" do
      owner = Bank::Owner.new("George", "101 South 1st")
      id = 1337
      balance = 100.0
      open_date = "Jan 2"

      account = Bank::Account.new(id, balance, open_date, owner)

      account.owner.name.must_equal account.owner.name
    end
    # it "Takes an ID and an initial balance" do
    #   id = 1337
    #   balance = 100.0
    #   account = Bank::Account.new(id, balance)
    #
    #   account.must_respond_to :id
    #   account.id.must_equal id
    #
    #   account.must_respond_to :balance
    #   account.balance.must_equal balance
    # end

    it "Raises an ArgumentError when created with a negative balance" do
      # Note: we haven't talked about procs yet. You can think
      # of them like blocks that sit by themselves.
      # This code checks that, when the proc is executed, it
      # raises an ArgumentError.
      proc {
        owner = Bank::Owner.new("George", "101 South 1st")
        Bank::Account.new(1337, -100.0, owner)
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      owner = Bank::Owner.new("George", "101 South 1st")

      # If this raises, the test will fail. No 'must's needed!
      Bank::Account.new(1337, 0, owner)
    end
  end

  describe "Account#withdraw" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      owner = Bank::Owner.new("George", "101 South 1st")

      account = Bank::Account.new(1337, start_balance, owner)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end


    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      owner = Bank::Owner.new("George", "101 South 1st")
      account = Bank::Account.new(1337, start_balance, owner)

      updated_balance = account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      owner = Bank::Owner.new("George", "101 South 1st")
      account = Bank::Account.new(1337, start_balance, owner)

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
      owner = Bank::Owner.new("George", "101 South 1st")
      account = Bank::Account.new(1337, start_balance, owner)

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Allows the balance to go to 0" do
      owner = Bank::Owner.new("George", "101 South 1st")
      account = Bank::Account.new(1337, 100.0, owner)
      updated_balance = account.withdraw(account.balance)
      updated_balance.must_equal 0
      account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -25.0
      owner = Bank::Owner.new("George", "101 South 1st")
      account = Bank::Account.new(1337, start_balance, owner)

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do
    it "Increases the balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      owner = Bank::Owner.new("George", "101 South 1st")
      account = Bank::Account.new(1337, start_balance, owner)

      account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      owner = Bank::Owner.new("George", "101 South 1st")
      account = Bank::Account.new(1337, start_balance, owner)

      updated_balance = account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      start_balance = 100.0
      deposit_amount = -25.0
      owner = Bank::Owner.new("George", "101 South 1st")
      account = Bank::Account.new(1337, start_balance, owner)

      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do
    #   - Account.all returns an array -done
    it "Returns an array of all accounts" do
      all_accounts = Bank::Account.all
      all_accounts.must_be_kind_of Array
    end

    #   - Everything in the array is an Account -done
    it "Each item in all_accounts is an Account" do
      all_accounts = Bank::Account.all
      all_accounts.each do |account|
        account.must_be_instance_of Bank::Account
      end
    end

    #   - The number of accounts is correct
    it "Number of accounts in all_accounts should be same as number of lines in my_file" do
      all_accounts = Bank::Account.all
      num_of_accounts = all_accounts.length
      my_file = CSV.open("support/accounts.csv")
      num_of_lines = 0
      my_file.each do |line|
        num_of_lines += 1
      end

      num_of_accounts.must_equal num_of_lines
    end

    #   - The ID and balance of the first and last
    #       accounts match what's in the CSV file
    it "id and balance of first account matches CSV file" do
      all_accounts = Bank::Account.all
      my_file = CSV.open("support/accounts.csv")
      lines = []
      my_file.each do |line|
        lines << line
      end
      all_accounts[0].balance.must_equal lines[0][1].to_f
      all_accounts[0].id.must_equal lines[0][0]
    end

    it "id and balance of last account matches CSV file" do
      all_accounts = Bank::Account.all
      my_file = CSV.open("support/accounts.csv")
      lines = []
      my_file.each do |line|
        lines << line
      end
      all_accounts[-1].balance.must_equal lines[-1][1].to_f
      all_accounts[-1].id.must_equal lines[-1][0]
    end

  end

  describe "Account.find" do
    it "Returns an account that exists" do
      test_id = 15151
      found_account = Bank::Account.find(test_id)
      found_account.id.to_i.must_equal test_id.to_i
    end

    it "Can find the first account from the CSV" do
      test_id = 1212
      test_balance = 1235667
      test_open_date = "1999-03-27 11:30:09 -0800"
      found_account = Bank::Account.find(test_id)
      found_account.id.to_i.must_equal test_id.to_i
      found_account.balance.to_i.must_equal test_balance.to_i
      found_account.open_date.must_equal test_open_date
    end

    it "Can find the last account from the CSV" do
      test_id = 15156
      test_balance = 4356772
      test_open_date = "1994-11-17 14:04:56 -0800"
      found_account = Bank::Account.find(test_id)
      found_account.id.to_i.must_equal test_id.to_i
      found_account.balance.to_i.must_equal test_balance.to_i
      found_account.open_date.must_equal test_open_date
      # TODO: Your test code here!
    end

    it "Raises an error for an account that doesn't exist" do
      test_id = 2
      # found_account = Bank::Account.find(test_id)
      proc {
        Bank::Account.find(test_id)
      }.must_raise ArgumentError
    end
  end
  describe "Owner.all" do
    #   - Owner.all returns an array
    it "Returns an array of all accounts" do
      all_owners = Bank::Owner.all
      all_owners.must_be_kind_of Array
    end

    #   - Everything in the array is an Owner
  #   it "Each item in all_owners is an Owner" do
  #     all_owners = Bank::Owner.all
  #     all_owners.each do |owner|
  #       owner.must_be_instance_of Bank::Owner
  #     end
  #   end
  #
  #   #   - The number of Owners is correct
  #   it "Number of owners in all_owners should be same as number of lines in my_file" do
  #     all_owners = Bank::Owner.all
  #     num_of_owners = all_owners.length
  #     my_file = CSV.open("support/owners.csv")
  #     num_of_lines = 0
  #     my_file.each do |line|
  #       num_of_lines += 1
  #     end
  #
  #     num_of_owners.must_equal num_of_lines
  #   end
  #
  #   #   - The ID and last_name of the first and last
  #   #       owners match what's in the CSV file
  #   it "id and last_name of first owner matches CSV file" do
  #     all_owners = Bank::Owner.all
  #     my_file = CSV.open("support/owners.csv")
  #     lines = []
  #     my_file.each do |line|
  #       lines << line
  #     end
  #     all_owners[0].last_name.must_equal lines[0][1]
  #     all_owners[0].id.must_equal lines[0][0]
  #   end
  #
  #   it "id and last_name of last owner matches CSV file" do
  #     all_owners = Bank::Owner.all
  #     my_file = CSV.open("support/owners.csv")
  #     lines = []
  #     my_file.each do |line|
  #       lines << line
  #     end
  #     all_owners[-1].last_name.must_equal lines[-1][1]
  #     all_owners[-1].id.must_equal lines[-1][0]
  #   end
  #
  # end
  #
  # describe "Owner.find" do
  #   it "Returns an owner that exists" do
  #     test_id = xxxx
  #     found_owner = Bank::Owner.find(test_id)
  #     found_owner.id.to_i.must_equal test_id.to_i
  #   end
  #
  #   it "Can find the first owner from the CSV" do
  #     test_id = xxx
  #     test_last_name = xxx
  #     found_owner = Bank::Owner.find(test_id)
  #     found_owner.id.to_i.must_equal test_id.to_i
  #     found_owner.last_name.must_equal test_last_name
  #   end
  #
  #   it "Can find the last owner from the CSV" do
  #     test_id = xx
  #     test_last_name = xxx
  #     found_account = Bank::Owner.find(test_id)
  #     found_account.id.to_i.must_equal test_id.to_i
  #     found_account.last_name.to_i.must_equal test_last_name.to_i
  #   end
  #
  #   it "Raises an error for an owner that doesn't exist" do
  #     test_id = xxx
  #     # found_owner = Bank::Owner.find(test_id)
  #     proc {
  #       Bank::Owner.find(test_id)
  #     }.must_raise ArgumentError
  #   end
  end
end
