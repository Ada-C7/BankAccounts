require_relative 'spec_helper.rb'
require_relative '../lib/account'

describe "Wave 1" do

  describe "Account#initialize" do
    it "Takes an ID, initial balance, and date" do
      id = 1337
      balance = 100
      date = "1999-03-27 11:30:09 -0800"
      account = Bank::Account.new(id, balance, date)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

      account.must_respond_to :date
      account.date.must_equal DateTime.parse(date)
    end

    it "Raises an ArgumentError when created with a negative balance" do
      proc {
        Bank::Account.new(1337, -100.0, "1999-03-27 11:30:09 -0800")
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      Bank::Account.new(1337, 0, "1999-03-27 11:30:09 -0800")
    end

    it "Creates an owner if account id matches an owner id" do
      account = Bank::Account.new(1212, 1235667, "1999-03-27 11:30:09 -0800")
      account.must_respond_to :owner
      account.owner.first_name.must_equal "Kathleen"
    end

  end

  describe "Account#withdraw" do
    it "Reduces the balance" do
      start_balance = 100
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      start_balance = 100
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      # Another proc! This test expects something to be printed
      # to the terminal, using 'must_output'. /.+/ is a regular
      # expression matching one or more characters - as long as
      # anything at all is printed out the test will pass.
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output (/.+/)
    end

    it "Doesn't modify the balance if the account would go negative" do
      start_balance = 100
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Allows the balance to go to 0" do
      account = Bank::Account.new(1337, 100, "1999-03-27 11:30:09 -0800")
      updated_balance = account.withdraw(account.balance)
      updated_balance.must_equal 0
      account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100
      withdrawal_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do
    it "Increases the balance" do
      start_balance = 100
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      updated_balance = account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      start_balance = 100
      deposit_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "1999-03-27 11:30:09 -0800")

      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#add_owner" do
    it "Adds owner to Account" do
      owner_hash = {
        id: 4,
        last_name: "Lovelace",
        first_name: "Ada",
        address: "123 Fake Street",
        city: "Fake City",
        state: "Fake State"
      }
      owner = Bank::Owner.new(owner_hash)
      account = Bank::Account.new(1337, 100, "1999-03-27 11:30:09 -0800")
      account.add_owner(owner)

      account.must_respond_to :owner
      account.owner.id.must_equal owner.id

    end
  end
end

describe "Wave 2" do
  before do
    @account_array = Bank::Account.all
    @csv_info = CSV.read('support/accounts.csv')
  end

  describe "Account#all" do
    it "Account.all returns an array" do
      @account_array.must_be_instance_of Array
    end

    it "Everything in the array is an Account" do
      @account_array.each do |account|
        account.must_be_instance_of Bank::Account
      end
    end

    it "The number of accounts is correct" do
      @account_array.length.must_equal @csv_info.count
    end

    it "The ID, balance, and date of the first & last accounts are correct" do
      @account_array[0].id.must_equal @csv_info[0][0].to_i
      @account_array[0].balance.must_equal @csv_info[0][1].to_i
      @account_array[0].date.must_equal DateTime.parse(@csv_info[0][2])

      @account_array[-1].id.must_equal @csv_info[-1][0].to_i
      @account_array[-1].balance.must_equal @csv_info[-1][1].to_i
      @account_array[-1].date.must_equal DateTime.parse(@csv_info[-1][2])
    end
  end

  describe "Account#find" do
    it "Returns an account that exists" do
      Bank::Account.find(15151).must_be_instance_of Bank::Account
      Bank::Account.find(15151).balance.must_equal 9844567
    end

    it "Can find the first account from the CSV" do
      Bank::Account.find(@csv_info[0][0].to_i).must_be_instance_of Bank::Account
      Bank::Account.find(@csv_info[0][0].to_i).balance.must_equal @csv_info[0][1].to_i
    end

    it "Can find the last account from the CSV" do
      Bank::Account.find(@csv_info[-1][0].to_i).must_be_instance_of Bank::Account
      Bank::Account.find(@csv_info[-1][0].to_i).balance.must_equal @csv_info[-1][1].to_i
    end

    it "Raises an error for an account that doesn't exist" do
      proc { Bank::Account.find(789078) }.must_raise ArgumentError
    end
  end
end
