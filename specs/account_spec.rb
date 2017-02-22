require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
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
      

    end

      # TODO: Your test code here!
      # Useful checks might include:
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    # end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      # TODO: Your test code here!
    end

    it "Can find the first account from the CSV" do
      # TODO: Your test code here!
    end

    it "Can find the last account from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for an account that doesn't exist" do
      # TODO: Your test code here!
    end
  end
end
