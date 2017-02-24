require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/account'
require_relative '../lib/owner'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "Wave 1" do
  # before do
  #   @owner_hash = {
  #     :in_first_name => "Grace",
  #     :in_last_name => "Hopper",
  #     :in_address => "456 Anytown, USA",
  #     :in_phone => "206-440-0725"
  #   }
  # end



  describe "Account#initialize" do
    it "Takes an ID, and an initial balance and an owner of Owner class" do
      id = 1337
      balance = 100.0
      opendate = "1999-03-27 11:30:09 -0800"
      owner = Bank::Owner.new(1, "Hopper", "Grace", "123 Main St", "Seattle", "WA")
      account = Bank::Account.new(id, balance, opendate, owner)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

      account.must_respond_to :owner
      account.owner.must_be_instance_of Bank::Owner

      # account.must_respond_to :owner
      # account.owner.must_equal @owner_hash
    end

    it "Raises an ArgumentError when created with a negative balance" do
      # Note: we haven't talked about procs yet. You can think
      # of them like blocks that sit by themselves.
      # This code checks that, when the proc is executed, it
      # raises an ArgumentError.
      proc {
        Bank::Account.new(1337, -100.0, "1999-03-27 11:30:09 -0800" )
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






# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do
    # it "Returns an array of all accounts" do
    #   # TODO: Your test code here!
    #   # Useful checks might include:
    #   #   - Account.all returns an array
    #   #   - Everything in the array is an Account
    #   #   - The number of accounts is correct
    #   #   - The ID and balance of the first and last
    #   #       accounts match what's in the CSV file
    #   # Feel free to split this into multiple tests if needed
    # end

    before do
      @accounts = Bank::Account.all
    end

    it "returns an array" do
      @accounts.must_be_instance_of Array

    end

    it "Everything in the Array is an Account" do
      @accounts.each do |element|
        element.must_be_instance_of Bank::Account
      end
    end

    it "Has twelve accounts" do
      check_array = CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/accounts.csv")
      @accounts.length.must_equal check_array.length

      #could also do
      @accounts.length.must_equal CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/accounts.csv").length


    end
  end

  describe "Account.find" do


    it "Returns an account that exists" do
      find_account = Bank::Account.find(1213)
      find_account.must_be_instance_of Bank::Account
    end

    it "Can find the first account from the CSV" do
      test_array = CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/accounts.csv")
      id_check = test_array[0][0].to_i
      find_account = Bank::Account.find(1212)
      find_account.id.must_equal id_check
    end

      it "Can find the last account from the CSV" do
        test_array = CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/accounts.csv")
        id_check= test_array[-1][0].to_i
        find_account = Bank::Account.find(15156)
        find_account.id.must_equal id_check

      end

      it "Raises an error for an account that doesn't exist" do
        proc {
          Bank::Account.find(7777)
        }.must_output /.+/
      end
  end
end
