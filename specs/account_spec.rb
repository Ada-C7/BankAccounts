require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'

describe "Wave 1" do

  describe "Account#initialize" do
    it "Takes an ID and an initial balance" do
      # skip
      id = 1337
      balance = 100.0
      date = "2013-19-07 09:04:56 -0700"
      account = Bank::Account.new(id, balance, date)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

      account.must_respond_to :opening_date
      account.opening_date.must_equal date

    end

    it "Raises an ArgumentError when created with a negative balance" do
      # skip
      # Note: we haven't talked about procs yet. You can think
      # of them like blocks that sit by themselves.
      # This code checks that, when the proc is executed, it
      # raises an ArgumentError.
      proc {
        Bank::Account.new(1337, -100.0, "2013-19-07 09:04:56 -0700")
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      # skip
      # If this raises, the test will fail. No 'must's needed!
      Bank::Account.new(1337, 0, "2013-19-07 09:04:56 -0700")
    end
  end

  describe "Account#withdraw" do

    it "Reduces the balance" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "2013-19-07 09:04:56 -0700")

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "2013-19-07 09:04:56 -0700")

      updated_balance = account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance, "2013-19-07 09:04:56 -0700")

      # Another proc! This test expects something to be printed
      # to the terminal, using 'must_output'. /.+/ is a regular
      # expression matching one or more characters - as long as
      # anything at all is printed out the test will pass.
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go negative" do
      # skip
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance, "2013-19-07 09:04:56 -0700")

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Allows the balance to go to 0" do
      # skip
      account = Bank::Account.new(1337, 100.0, "2013-19-07 09:04:56 -0700")
      updated_balance = account.withdraw(account.balance)
      updated_balance.must_equal 0
      account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      # skip
      start_balance = 100.0
      withdrawal_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "2013-19-07 09:04:56 -0700")

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do

    it "Increases the balance" do
      # skip
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "2013-19-07 09:04:56 -0700")

      account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      # skip
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "2013-19-07 09:04:56 -0700")

      updated_balance = account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      # skip
      start_balance = 100.0
      deposit_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "2013-19-07 09:04:56 -0700")

      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end
  end

  # describe "Account#Owner" do
  #
  #   it "adds a owner class object that you can use to access own info" do
  #     owner_info = {
  #                       last_name: "Cobb",
  #                       first_name: "Cynthia",
  #                       phone_number: "234-456-7890",
  #                       street: "123 Street",
  #                       city: "seattle",
  #                       zipcode: "98011",
  #                       state: "WA"
  #                       }
  #     owner = Bank::Owner.new(owner_info)
  #     account = Bank::Account.new(1337, 890)
  #     account.add_owner(owner).must_respond_to :last_name
  #     account.add_owner(owner).must_respond_to :first_name
  #     account.add_owner(owner).must_respond_to :phone_number
  #   end
  # end
end



# # # TODO: change 'xdescribe' to 'describe' to run these tests

describe "Wave 2" do
  # skip
  describe "Account.all" do
    # skip
    it "Returns an array of all accounts" do
      Bank::Account.all.must_be_instance_of Array
      Bank::Account.all.each { |account_object| account_object.must_be_instance_of Bank::Account }
      Bank::Account.all.length.must_equal 12
      Bank::Account.all.each { |acount_object| acount_object.must_respond_to :id }
      Bank::Account.all.each { |acount_object| acount_object.must_respond_to :balance }
    end
      # Useful checks might include:
      #   - Account.all returns an array
      #   - Everything in the array is an Account
      #   - The number of accounts is correct
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file
      # Feel free to split this into multiple tests if needed
  end

  describe "Account.find" do

    it "Returns an account that exists" do

      Bank::Account.all.each do |account|
        Bank::Account.find(account.id).must_be_instance_of Bank::Account
      end
      # Bank::Account.find(1212).must_respond_to :id
      # Bank::Account.find(1212).must_respond_to :balance
    end

    it "Can find the first account from the CSV" do
      Bank::Account.all
      Bank::Account.find(1212).must_be_instance_of Bank::Account
      Bank::Account.find(1212).must_respond_to :id
      Bank::Account.find(1212).must_respond_to :balance
    end

    it "Can find the last account from the CSV" do
      Bank::Account.all
      Bank::Account.find(15156).must_be_instance_of Bank::Account
      Bank::Account.find(15156).must_respond_to :id
      Bank::Account.find(15156).must_respond_to :balance
    end

    it "Raises an error for an account that doesn't exist" do
      Bank::Account.all
      proc { Bank::Account.find(0) }.must_raise ArgumentError
    end
  end
end
