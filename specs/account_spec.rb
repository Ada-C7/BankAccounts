require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'
require_relative '../lib/owner'

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
      name = "John Smith"
      address = "1234 6th St Seattle, WA"
      phone = "834-928-3947"
      owner = Bank::Owner.new(name, address, phone)

      owner.must_respond_to :name
      owner.name.must_equal name

      owner.must_respond_to :address
      owner.address.must_equal address

      owner.must_respond_to :phone
      owner.phone.must_equal phone
    end

    it "Saves an owner object inside the Account class" do
      name = "John Smith"
      address = "1234 6th St Seattle, WA"
      phone = "834-928-3947"
      account = Bank::Account.new(1337, 100.0)
      owner_to_add = Bank::Owner.new(name, address, phone)
      account.add_owner(owner_to_add)
      account.owner.must_equal owner_to_add
    end
  end

end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do

    it "Returns an array" do
      accounts = Bank::Account.all
      expect(accounts.class).must_equal Array
    end

    it "Everything is an array is an Account" do
      accounts = Bank::Account.all
      accounts.each do |account|
        expect(account.class).must_equal Bank::Account
      end
    end
      #   - The number of accounts is correct
      it "Has the correct amounts of account" do
        count = 0
        accounts = Bank::Account.all
        CSV.open("support/accounts.csv", 'r').each do |account|
          count += 1
        end
        expect(accounts.length).must_equal count

      end
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file
      # Feel free to split this into multiple tests if needed

  end

  describe "Account.find" do
    it "Returns an account that exists" do
      skip
      # TODO: Your test code here!
    end

    it "Can find the first account from the CSV" do
      skip
      # TODO: Your test code here!
    end

    it "Can find the last account from the CSV" do
      skip
      # TODO: Your test code here!
    end

    it "Raises an error for an account that doesn't exist" do
      skip
      # TODO: Your test code here!
    end
  end
end
