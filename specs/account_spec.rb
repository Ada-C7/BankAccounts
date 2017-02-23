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
  xdescribe "Owner#initialize" do
    it "Takes an ID, name, and address" do
      id = 101
      name = "Owner Name"
      address = "101 Wave Street"
      owner = Bank::Owner.new(id, name, address)

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

    end
    it "Returns an array of all accounts" do
      #Bank::Account.import_accounts_csv("support/accounts.csv")
      Bank::Account.all.must_be_kind_of Array
      puts "Accounts is #{Bank::Account.all}"
    end

    it "Everything in the array is an Account" do
      #Bank::Account.import_accounts_csv("support/accounts.csv")
      Bank::Account.all.each do |account|
        account.must_be_instance_of Bank::Account
      end
    end
  describe "check accounts_array length" do
    before do
      @all_accounts_array = Bank::Account.all
    end

    it "The number of accounts is correct = 12" do
      #skip

      #Bank::Account.import_accounts_csv("support/accounts.csv")
      @all_accounts_array.length.must_equal 12
    end
  end
    it "The ID and balance of the first account match what's in the CSV file" do
      #skip
      test_id = 1212
      test_balance = 1235667

      #Bank::Account.import_accounts_csv("support/accounts.csv")

      first_instance = Bank::Account.all[0]
      first_instance.id.must_equal test_id
      first_instance.balance.must_equal test_balance

    end

    it "The ID and balance of the last account match what's in the CSV file" do

      test_id = 15156
      test_balance = 4356772

      #Bank::Account.import_accounts_csv("support/accounts.csv")

      puts "last_instance = #{Bank::Account.all[11]}"
      last_instance = Bank::Account.all[11]
      last_instance.id.must_equal test_id
      last_instance.balance.must_equal test_balance

    end

    it "Returns an array of all accounts" do
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Account.all returns an array
      #   - Everything in the array is an Account
      #   - The number of accounts is correct
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    end
      # describe "Account.self.import_csv" do
      #   it 'returns an array' do
      #
      #   end
      # end
      #   it "takes an ID, balance, and open_date" do
      #     id = 333
      #     balance = 22222
      #     open_date = "2222-03-27 11:30:09 -0800"
      #     account = Bank::Account.new(id, balance, open_date)
      #
      #     account.must_respond_to :id
      #     account.must_equal id
      #
      #     account.must_respond_to :balnce
      #     account.must_equal balance
      #
      #     account.must_respond_to :open_date
      #     account.must_equal open_date
      #
      #     account.length must_equal 12
      # end
  end

  xdescribe "Account.find" do
    it "Returns an account that exists" do
      Bank::Account.import_accounts_csv("support/accounts.csv")

      Bank.Account.must_respond_to :find
      #Bank::Account.find(1212).wont_equal nil
      proc {
        Bank::Account.find(account_id)
      }.wont_raise ArgumentError

      Bank::Account.find(1212).must_be_instance_of Bank::Account
    end

    it "Can find the first account from the CSV" do
      account_id = 1212
      Bank::Account.import_accounts_csv("support/accounts.csv")

      Bank.Account.must_respond_to :find
      #Bank::Account.find(account_id).wont_equal nil
      proc {
        Bank::Account.find(account_id)
      }.wont_raise ArgumentError

      Bank::Account.find(account_id).must_be_instance_of Bank::Account
    end

    it "Can find the last account from the CSV" do
      account_id = 15156
      Bank::Account.import_accounts_csv("support/accounts.csv")

      Bank.Account.must_respond_to :find
      #Bank::Account.find(account_id).wont_equal nil
      proc {
        Bank::Account.find(account_id)
      }.wont_raise ArgumentError

      Bank::Account.find(account_id).must_be_instance_of Bank::Account
    end

    it "Raises an error for an account that doesn't exist" do
      ccount_id = 9999

      Bank::Account.import_accounts_csv("support/accounts.csv")

      Bank.Account.must_respond_to :find

      proc {
        Bank::Account.find(account_id)
      }.must_raise ArgumentError
    end
  end
end
