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
      open_date = "1999-03-27 11:30:09 -0800"
      account = Bank::Account.new(id, balance, open_date)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

      account.must_respond_to :open_date
      account.open_date.must_equal DateTime.parse(open_date)
    end

    it "Raises an ArgumentError when created with a negative balance" do
      proc {
        Bank::Account.new(1337, -100.0, "1999-03-27 11:30:09 -0800")
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

  describe "Owner#added property to Account" do
    it "Initializes account without owner property" do
      id = 1337
      balance = 100.0
      account = Bank::Account.new(id, balance, "1999-03-27 11:30:09 -0800")

      account.must_respond_to :owner
      account.owner.class.must_equal Bank::Owner
      account.owner.id.must_equal 0
    end

    it "Raise an error if the owner_hash is missing a key" do
      # id = 1337
      # balance = 100.0
      # open_date = "1999-03-27 11:30:09 -0800"
      owner_hash = {
        id: 1024,
        last_name: "smith",
        street_address: "123 main street",
        city: "seattle",
        state: "WA"
      }
      proc {
        Bank::Owner.new(owner_hash)
      }.must_raise ArgumentError
    end


    it "Initializes account with owner property" do
      id = 1337
      balance = 100.0
      open_date = "1999-03-27 11:30:09 -0800"
      owner_hash = {
        id: 1024,
        first_name: "ginny",
        last_name: "smith",
        street_address: "123 main street",
        city: "seattle",
        state: "WA"
      }
      owner = Bank::Owner.new(owner_hash)
      account = Bank::Account.new(id, balance, open_date, owner)

      account.must_respond_to :owner
      account.owner.class.must_equal Bank::Owner
    end

    it "Only accounts without initial owner property can be updated" do
      owner_hash = {
        id: 10,
        first_name: "ginny",
        last_name: "smith",
        street_address: "123 main street",
        city: "seattle",
        state: "WA"
      }

      test_hash = {
        id: 9,
        first_name: "fran",
        last_name: "swan",
        street_address: "456 grand street",
        city: "columbus",
        state: "OH"
      }

      account_nil = Bank::Account.new(12345, 12, "1999-03-27 11:30:09 -0800")
      account = Bank::Account.new(12346, 0, "1999-03-27 11:30:09 -0800", Bank::Owner.new(test_hash))

      account_nil.update_owner_data(owner_hash)
      account.update_owner_data(owner_hash)

      account_nil.owner.id.must_equal 10
      account_nil.owner.first_name.must_equal "ginny"
      account_nil.owner.last_name.must_equal "smith"
      account_nil.owner.street_address.must_equal "123 main street"
      account_nil.owner.city.must_equal "seattle"
      account_nil.owner.state.must_equal "WA"

      account.owner.id.must_equal 9
      account.owner.first_name.must_equal "fran"
      account.owner.last_name.must_equal "swan"
      account.owner.street_address.must_equal "456 grand street"
      account.owner.city.must_equal "columbus"
      account.owner.state.must_equal "OH"
    end
  end
end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do
    it "Returns an array of all accounts" do
      # TODO
      # everything in the array is an Account
      all_array = Bank::Account.all

      all_array.each do |account|
        account.class.must_equal Bank::Account
      end

      # the number of accounts is correct
      #all_array.length.must_equal 12
      all_array.length.must_equal CSV.read("support/accounts.csv").length

      # the ID and balance of the first and last accounts match what's in the CSV file
      all_array[0].id.must_equal 1212
      all_array[0].balance.must_equal 1235667
      all_array[0].open_date.must_equal DateTime.parse("1999-03-27 11:30:09 -0800")
      all_array[-1].id.must_equal 15156
      all_array[-1].balance.must_equal 4356772
      all_array[-1].open_date.must_equal DateTime.parse("1994-11-17 14:04:56 -0800")
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      # TODO: Your test code here!
      account = Bank::Account.find(1213)
      account.id.must_equal 1213
      account.balance.must_equal 66367
      account.open_date.must_equal DateTime.parse("2010-12-21 12:21:12 -0800")
    end

    it "Can find the first account from the CSV" do
      # TODO: Your test code here!
      account = Bank::Account.find(1212)
      account.id.must_equal 1212
      account.balance.must_equal 1235667
      account.open_date.must_equal DateTime.parse("1999-03-27 11:30:09 -0800")
    end

    it "Can find the last account from the CSV" do
      # TODO: Your test code here!
      account = Bank::Account.find(15156)
      account.id.must_equal 15156
      account.balance.must_equal 4356772
      account.open_date.must_equal DateTime.parse("1994-11-17 14:04:56 -0800")
    end

    it "Raises an error for an account that doesn't exist" do
      # TODO: Your test code here!
      proc {
        Bank::Account.find(100233332223003)
      }.must_raise ArgumentError
    end

    it "Raises an error for an invalid input data type" do
      # TODO: Your test code here!
      proc {
        Bank::Account.find(0)
      }.must_raise ArgumentError
      proc {
        Bank::Account.find(-1233)
      }.must_raise ArgumentError
      proc {
        Bank::Account.find("happy dog")
      }.must_raise ArgumentError
    end
  end

  describe "Owner.all" do
    it "Returns an array of all owners" do
      # TODO
      # everything in the array is an Owner
      all_array = Bank::Owner.all

      all_array.each do |owner|
        owner.class.must_equal Bank::Owner
      end

      # the number of accounts is correct
      #all_array.length.must_equal 12
      all_array.length.must_equal CSV.read("support/owners.csv").length

      # the ID, last_name, first_name, street_address, city, state of the first
      # and last accounts match what's in the CSV file
      all_array[0].id.must_equal 14
      all_array[0].last_name.must_equal "Morales"
      all_array[0].first_name.must_equal "Wanda"
      all_array[0].street_address.must_equal "9003 Gerald Hill"
      all_array[0].city.must_equal "Honolulu"
      all_array[0].state.must_equal "Hawaii"

      all_array[-1].id.must_equal 25
      all_array[-1].last_name.must_equal "Clark"
      all_array[-1].first_name.must_equal "Kathleen"
      all_array[-1].street_address.must_equal "72984 Chive Hill"
      all_array[-1].city.must_equal "New York City"
      all_array[-1].state.must_equal "New York"
    end
  end

  describe "Owner.find" do
    it "Returns an owner that exists" do
      owner = Bank::Owner.find(18)
      owner.id.must_equal 18
      owner.last_name.must_equal "Gonzalez"
      owner.first_name.must_equal "Laura"
      owner.street_address.must_equal "310 Hauk Street"
      owner.city.must_equal "Springfield"
      owner.state.must_equal "Illinois"
    end

    it "Can find the first owner from the CSV" do
      owner = Bank::Owner.find(14)
      owner.id.must_equal 14
      owner.last_name.must_equal "Morales"
      owner.first_name.must_equal "Wanda"
      owner.street_address.must_equal "9003 Gerald Hill"
      owner.city.must_equal "Honolulu"
      owner.state.must_equal "Hawaii"
    end

    it "Can find the last account from the CSV" do
      owner = Bank::Owner.find(25)
      owner.id.must_equal 25
      owner.last_name.must_equal "Clark"
      owner.first_name.must_equal "Kathleen"
      owner.street_address.must_equal "72984 Chive Hill"
      owner.city.must_equal "New York City"
      owner.state.must_equal "New York"
    end

    it "Raises an error for an owner that doesn't exist" do
      # TODO: Your test code here!
      proc {
        Bank::Owner.find(100233332223003)
      }.must_raise ArgumentError
    end

    it "Raises an error for an invalid input data type" do
      # TODO: Your test code here!
      proc {
        Bank::Owner.find(0)
      }.must_raise ArgumentError
      proc {
        Bank::Owner.find(-1233)
      }.must_raise ArgumentError
      proc {
        Bank::Owner.find("happy dog")
      }.must_raise ArgumentError
    end
  end
  describe "Use account_owners.csv to create owner property for existing " do
    it "Makes account instance when account.id and owner.id pair doesn not exist within csv file" do
      account = Bank::Account.new(1223222337, 0, "1999-03-27 11:30:09 -0800")
      account.owner.id.must_equal 0

      owner_hash = {
        id: 1000000,
        first_name: "ginny",
        last_name: "smith",
        street_address: "123 main street",
        city: "seattle",
        state: "WA"
      }
      account = Bank::Account.new(1223222337, 0, "1999-03-27 11:30:09 -0800", Bank::Owner.new(owner_hash))
      account.owner.id.must_equal 1000000

    end
  end
end
