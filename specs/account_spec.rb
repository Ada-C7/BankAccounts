require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'
require_relative '../lib/owner'
require 'csv'

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
      account = Bank::Account.new(1337, 100.0)

      updated_balance = account.withdraw(25.0)

      expected_balance = 75.0
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      start_balance = 100.0
      account = Bank::Account.new(1337, start_balance)

      # Another proc! This test expects something to be printed
      # to the terminal, using 'must_output'. /.+/ is a regular
      # expression matching one or more characters - as long as
      # anything at all is printed out the test will pass.
      proc {
        account.withdraw(200)
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

  describe "Wave 1 optionals" do
    it "Creates an owner class" do
      owner = Bank::Owner.new("name", "address", "phone")
      expect(owner.class).must_equal Bank::Owner
    end
    it "Assigns relevant information to the Owner" do
      id = 01
      name = "John Smith"
      address = "1234 6th St Seattle, WA"
      owner = Bank::Owner.new(id, name, address)

      owner.must_respond_to :name
      owner.name.must_equal name

      owner.must_respond_to :address
      owner.address.must_equal address

      owner.must_respond_to :id
      owner.id.must_equal id
    end

    it "Saves an owner object inside the Account class" do
      id = 01
      name = "John Smith"
      address = "1234 6th St Seattle, WA"
      account = Bank::Account.new(1337, 100.0)
      owner_to_add = Bank::Owner.new(id, name, address)
      account.add_owner(owner_to_add)
      account.owner.must_equal owner_to_add
    end
  end

end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do

  before do
    @accounts = Bank::Account.all
  end

  describe "Account.all" do

    it "Returns an array" do
      expect(@accounts.class).must_equal Array
    end

    it "Everything is an array is an Account" do
      @accounts.each do |account|
        expect(account.class).must_equal Bank::Account
      end
    end

      it "Has the correct amounts of account" do
        expect(@accounts.length).must_equal CSV.read("support/accounts.csv").length
      end

      it "The ID + Balance of first and last account match CSV file" do
        test_array = []
        CSV.open("support/accounts.csv", 'r').each do |account|
          test_array << account
        end
        balance_one = Integer(test_array[0][1])
        balance_two = Integer(test_array[-1][1])

        expect(@accounts[0].id).must_equal test_array[0][0]
        expect(@accounts[0].balance).must_equal balance_one
        expect(@accounts[-1].id).must_equal test_array[-1][0]
        expect(@accounts[-1].balance).must_equal balance_two
      end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      id_check = @accounts[0].id
      account = Bank::Account.find(id_check)
      expect(account.id).must_equal id_check
    end

    it "Can find the first account from the CSV" do
      test_array = []
      CSV.open("support/accounts.csv", 'r').each do |account|
        test_array << account
      end
      id_check = test_array[0][0]
      account = Bank::Account.find(id_check)
      expect(account.id).must_equal id_check
    end

    it "Can find the last account from the CSV" do
      test_array = []
      CSV.open("support/accounts.csv", 'r').each do |account|
        test_array << account
      end
      id_check = test_array[-1][0]
      account = Bank::Account.find(id_check)
      expect(account.id).must_equal id_check
    end

    it "Raises an error for an account that doesn't exist" do
      proc {
        Bank::Account.find(21345)
      }.must_raise ArgumentError
    end
  end

  describe "Owner.all" do
    before do
      @owners = Bank::Owner.all
      @accounts = Bank::Account.all
    end

    it "Returns an array" do
      expect(@owners.class).must_equal Array
    end

    it "Everything is an array is an Owner" do
      @owners.each do |owner|
        expect(owner.class).must_equal Bank::Owner
      end
    end

    it "Has the correct amounts of account" do
      count = 0
      CSV.open("support/owners.csv", 'r').each do |account|
        count += 1
      end
      expect(@owners.length).must_equal count
    end
  end

  describe "Owner.find" do
    before do
      @owners = Bank::Owner.all
    end

    it "Returns an owner that exists" do
      id_check = @owners[0].id
      owner = Bank::Owner.find(id_check)
      expect(owner.id).must_equal id_check
    end

    it "Can find the first owner from the CSV" do
      test_array = []
      CSV.open("support/owners.csv", 'r').each do |owner|
        test_array << owner
      end
      id_check = test_array[0][0]
      owner = Bank::Owner.find(id_check)
      expect(owner.id).must_equal id_check
    end

    it "Can find the last owner from the CSV" do
      test_array = []
      CSV.open("support/owners.csv", 'r').each do |owner|
        test_array << owner
      end
      id_check = test_array[-1][0]
      owner = Bank::Owner.find(id_check)
      expect(owner.id).must_equal id_check
    end

    it "Raises an error for an owner that doesn't exist" do
      proc {
        Bank::Owner.find(21345)
      }.must_raise ArgumentError
    end

    # it "Finds a relationship between an Account and an Owner" do
    #   CSV.open("support/account_owners.csv", 'r').each do |owner|
    #     owner_id = owner[1]
    #     @accounts.each do |account|
    #       if account.id == owner[0]
    #         owner = Bank::Owner.find(owner_id)
    #         expect(owner.id).must_equal owner_id
    #       end
    #     end
    #   end
    #   end
    end
  end
