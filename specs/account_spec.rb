require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'

describe "Wave 1" do
  describe "Account#initialize" do
    it "Takes an ID and an initial balance" do
      id = 1337
      balance = 100.0
      date = "date"
      account = Bank::Account.new(id, balance, date)

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
        Bank::Account.new(1337, -100.0, "date")
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      # If this raises, the test will fail. No 'must's needed!
      Bank::Account.new(1337, 0, "date")
    end
  end

  describe "Account#withdraw" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "date")

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "date")

      updated_balance = account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance, "date")

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
      account = Bank::Account.new(1337, start_balance, "date")

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Allows the balance to go to 0" do
      account = Bank::Account.new(1337, 100.0, "date")
      updated_balance = account.withdraw(account.balance)
      updated_balance.must_equal 0
      account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "date")

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do
    it "Increases the balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "date")

      account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "date")

      updated_balance = account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      start_balance = 100.0
      deposit_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "date")

      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do
    it "Returns an array of all accounts" do
      #   - Account.all returns an array
      Bank::Account.all.class.must_equal Array, "Oops - the class is not an array"
      #   - Everything in the array is an Account
      Bank::Account.all.each do |account|
        if account.class != Bank::Account
          puts "Invalid account!"
        # else
        #   puts "Valid account!"
        end
      end
      #   - The number of accounts is correct
      Bank::Account.all.length.must_equal 12, "Oops you are missing an account!"
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file
      Bank::Account.all[0].id.must_equal 1212, "Oops the first id is not in the array"
      Bank::Account.all[0].balance.must_equal 1235667, "Oops the first balance is not in the array"
      Bank::Account.all[11].id.must_equal 15156, "Oops the last id is not in the array"
      Bank::Account.all[11].balance.must_equal 4356772, "Oops the last balance is not in the array"
      # TODO: Your test code here!
      # Feel free to split this into multiple tests if needed
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      sample_account = Bank::Account.find(1217)
      sample_account.must_be_instance_of Bank::Account
    end

    it "Can find the first account from the CSV" do
      first_account = Bank::Account.find(1212)
      first_account.id.must_equal 1212, "That ID is not for the first account."
      # TODO: Your test code here!
    end

    it "Can find the last account from the CSV" do
      last_account = Bank::Account.find(15156)
      last_account.id.must_equal 15156, "That ID is not for the last account."
      # TODO: Your test code here!
    end

    it "Raises an error for an account that doesn't exist" do
      proc {
        Bank::Account.find(8)
      }.must_raise ArgumentError
      # TODO: Your test code here!
    end
  end
end #
