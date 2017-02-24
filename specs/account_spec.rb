require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/account'
require_relative '../lib/owner'

describe "Wave 1" do

  before do
    brenna_hash = {id: 0522, last_name: "Darroch", first_name: "Brenna", st_address: "3426 Cotton Top Ct", city: "Fairfax", state: "VA"}
    @brenna = Bank::Owner.new(brenna_hash)
  end # remember, end is garbage collector!

  describe "Account#initialize" do
    it "Takes an ID, an initial balance, an open date, and an instance of Owner" do
      id = 1337
      balance = 100.0
      date = "Jan 1, 2001"
      account = Bank::Account.new(id, balance, date, @brenna)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

      account.must_respond_to :date
      account.date.must_equal date

      account.must_respond_to :owner
      account.owner.must_equal @brenna
    end

    it "Raises an ArgumentError when created with a negative balance" do
      proc {
        Bank::Account.new(1337, -100, "Jan 1, 2001", @brenna)
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      Bank::Account.new(1337, 0, "Jan 1, 2001", @brenna)
    end
  end

  describe "Account#withdraw" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)

      updated_balance = account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)

      updated_balance = account.withdraw(withdrawal_amount)
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Allows the balance to go to 0" do
      start_balance = 100
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)
      updated_balance = account.withdraw(account.balance)
      updated_balance.must_equal 0
      account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do
    it "Increases the balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)

      account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)

      updated_balance = account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      start_balance = 100.0
      deposit_amount = -25.0
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)

      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end

  end
end

describe "Wave 2" do
  # to make test adaptable (eg. calling diff account files), need to read in CSV file to spec file too

  before do
    @accounts = Bank::Account.all
  end

  describe "Account.all" do

    it "Returns an array of all accounts" do
      @accounts.must_be_kind_of Array
    end

    it "Everything in the array is an Account" do
      @accounts.each do |inst|
        inst.must_be_instance_of Bank::Account
      end
    end

    it "The number of accounts is correct" do
      @accounts.length.must_equal 12
    end

    it "The ID and balance of the first and last accounts match what's in the CSV file" do
      @accounts[0].id.must_equal 1212
      @accounts[0].balance.must_equal 1235667

      @accounts[-1].id.must_equal 15156
      @accounts[-1].balance.must_equal 4356772
    end

    it "The elements match what's in the file" do
      index = 0
      CSV.read("support/accounts.csv") do |line|
        accounts[index].id.must_equal line[0].to_i
        accounts[index].balance.must_equal line[1].to_f
        accounts[index].date.must_equal line[2]
        index += 1
      end
    end
  end

  describe "Account.find" do

    it "Returns an account that exists" do
      accounts = Bank::Account.all
      id_check = accounts[4].id
      account = Bank::Account.find(id_check)
      expect(account.id).must_equal id_check
    end

    it "Can find the first account from the CSV" do
      accounts = Bank::Account.all
      id_check = accounts[0].id
      account = Bank::Account.find(id_check)
      expect(account.id).must_equal id_check
    end

    it "Can find the last account from the CSV" do
      accounts = Bank::Account.all
      id_check = accounts[-1].id
      account = Bank::Account.find(id_check)
      expect(account.id).must_equal id_check
    end

    it "Raises an error for an account that doesn't exist" do
      proc {
        Bank::Account.find(12345)
        }.must_raise ArgumentError
    end

  end
end
