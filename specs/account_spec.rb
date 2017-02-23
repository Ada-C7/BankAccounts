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
      owner = nil
      account = Bank::Account.new(id, balance, "1999-03-27 11:30:09 -0800", owner)

      account.must_respond_to :owner
      account.owner.class.must_equal Bank::Owner
    end

    it "Initializes account with owner property" do
      id = 1337
      balance = 100.0
      open_date = "1999-03-27 11:30:09 -0800"
      owner_hash = {
                      customer_id: 1024,
                      first_name: "ginny",
                      last_name: "smith",
                      address: {
                                  street: "123 main street",
                                  city: "seattle",
                                  state: "WA",
                                  zipcode: "12345"
                               },
                      phone: "2065573099"
                    }
      owner = Bank::Owner.new(owner_hash)
      account = Bank::Account.new(id, balance, open_date, owner)

      account.must_respond_to :owner
      account.owner.class.must_equal Bank::Owner
    end

    it "Only accounts without initial owner property can be updated" do
      owner_hash = {
                      customer_id: 1024,
                      first_name: "ginny",
                      last_name: "smith",
                      address: {
                                  street: "123 main street",
                                  city: "seattle",
                                  state: "WA",
                                  zipcode: "12345"
                               },
                      phone: "2065573099"
                    }
      test_hash = {
                      customer_id: 8888,
                      first_name: "sally",
                      last_name: "smith",
                      address: {
                                  street: "456 1st street",
                                  city: "columbus",
                                  state: "OH",
                                  zipcode: "54322"
                               },
                      phone: "2234433099"
                    }
      account_nil = Bank::Account.new(12345, 12, "1999-03-27 11:30:09 -0800")
      account = Bank::Account.new(12346, 0, "1999-03-27 11:30:09 -0800", Bank::Owner.new(test_hash))

      account_nil.update_owner_data(owner_hash)
      account.update_owner_data(owner_hash)

      account_nil.owner.customer_id.must_equal 1024
      account_nil.owner.name.must_equal "ginny smith"
      account_nil.owner.phone.must_equal "2065573099"
      account_nil.owner.address.must_equal "123 main street, seattle, WA 12345"

      account.owner.customer_id.must_equal 8888
      account.owner.name.must_equal "sally smith"
      account.owner.phone.must_equal "2234433099"
      account.owner.address.must_equal "456 1st street, columbus, OH 54322"
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
      all_array.length.must_equal 12

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
end
