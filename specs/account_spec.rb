require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/account'

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

  describe "Owner#initialize" do
    it "Takes an name, address and phone_number" do
      name = "Elmo"
      address = "123 Sesame Street"
      phone_number = "(123)456-7890"
      owner = Bank::Owner.new(name, address, phone_number)

      owner.must_respond_to :name
      owner.name.must_equal name

      owner.must_respond_to :address
      owner.address.must_equal address

      owner.must_respond_to :phone_number
      owner.phone_number.must_equal phone_number
    end
  end
end


# This is the first time you are writing your own tests, the comments that were
# created was guidance to how you could structure or give frame work / outline
#
# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do
    before do
      @accounts_array = Bank::Account.all
    end
    it "Returns an array of all accounts" do
      # TODO: Your test code here!

      # Useful checks might include:
      #   - Account.all returns an array
      #accounts_array = Bank::Account.all
      @accounts_array.class.must_equal Array
    end
    #   - Everything in the array is an Account
    it "Everything in the array is an Account" do
      first_account = @accounts_array[0]
      first_account.class.must_equal Bank::Account
    end
    #   - The number of accounts is correct
    it "The number of accounts is correct" do
      number_of_accounts = @accounts_array.length
      number_of_accounts.must_equal 12
    end

    #   - The ID and balance of the first and last
    it "The ID and balance of the first and last" do
      id_of_first = @accounts_array[0].id
      id_of_first.must_equal 1212
      balance_for_first = @accounts_array[0].balance
      balance_for_first.must_equal 1235667

      id_of_last = @accounts_array[11].id
      id_of_last.must_equal 15156
      balance_for_last = @accounts_array[11].balance
      balance_for_last.must_equal 4356772
    end

    #       accounts match what's in the CSV file
    it "accounts match what's in the CSV file" do
      index = 0
      CSV.read("/Users/theresamanney/ada/week_three/Tuesday/BankAccounts/support/accounts.csv") do
          accounts[index].id.must_equal line[0].to_i
          accounts[index].balance.must_equal line[1].to_i
          accounts[index].datetime.must_equal line[2]

          index += 1
      end
    end
    # Feel free to split this into multiple tests if needed
  end

  describe "Account.find" do
    # describe "Account.all" do
    # This is a more DRY way to write this code, it was an example
    # before do
    #   @accounts = Bank::Account.all
    # end
    it "Returns an account that exists" do

      # TODO: Your test code here!
      account_exists = Bank::Account.find(1216)
      account_exists.must_be_instance_of Bank::Account
      #checking its the right account
      account_exists.id.must_equal 1216
      account_exists.balance.must_equal 100022
      account_exists.datetime.must_equal "2000-07-07 15:07:55 -0800"
    end

    it "Can find the first account from the CSV" do
      # TODO: Your test code here!
      account_exists = Bank::Account.find(1212)
      account_exists.must_be_instance_of Bank::Account

      account_exists.id.must_equal 1212
      account_exists.balance.must_equal 1235667
      account_exists.datetime.must_equal "1999-03-27 11:30:09 -0800"

    end

    it "Can find the last account from the CSV" do
      # TODO: Your test code here!

      account_exists = Bank::Account.find(15156)
      account_exists.must_be_instance_of Bank::Account

      account_exists.id.must_equal 15156
      account_exists.balance.must_equal 4356772
      account_exists.datetime.must_equal "1994-11-17 14:04:56 -0800"

    end

    it "Raises an error for an account that doesn't exist" do
      # TODO: Your test code here!
      proc {
        Bank::Account.find(11111)
      }.must_raise ArgumentError
    end
  end
end
