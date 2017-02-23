require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/account'
require_relative '../lib/owner'

describe "Wave 1" do

  before do
    brenna_hash = {name: "Brenna Darroch", address: "3426 Cotton Top Ct", birthday: "May 22, 1993", favefood: "chocolate"}
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

      account.owner.name.must_equal "Brenna Darroch"
      account.owner.address.must_equal "3426 Cotton Top Ct"
      account.owner.birthday.must_equal "May 22, 1993"
      account.owner.favefood.must_equal "chocolate"
    end

    it "Raises an ArgumentError when created with a negative balance" do
      # Note: we haven't talked about procs yet. You can think of them like blocks that sit by themselves.
      # This code checks that, when the proc is executed, it raises an ArgumentError.
      proc {
        Bank::Account.new(1337, -100, "Jan 1, 2001", @brenna)
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      # If this raises, the test will fail. No 'must's needed!
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
      # Another proc! This test expects something to be printed to the terminal, using 'must_output'. /.+/ is a regular expression matching one or more characters - as long as anything at all is printed out the test will pass.
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance, "Jan 1, 2001", @brenna)

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
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

  describe "Account.all" do
    it "Returns an array of all accounts" do
      #   - Account.all returns an array
      Bank::Account.all.must_be_kind_of Array
      #   - Everything in the array is an Account
      Bank::Account.all.each do |inst|
        inst.must_be_instance_of Bank::Account
      end
      #   - The number of accounts is correct
      Bank::Account.all.length.must_equal 12
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file
      Bank::Account.all[0].id.must_equal 1212
      Bank::Account.all[0].balance.must_equal 1235667

      Bank::Account.all[-1].id.must_equal 15156
      Bank::Account.all[-1].balance.must_equal 4356772

    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      Bank::Account.find(1216).must_equal Bank::Account.all[4]
    end

    it "Can find the first account from the CSV" do
      Bank::Account.find(1212).must_equal Bank::Account.all[0]
    end

    it "Can find the last account from the CSV" do
      Bank::Account.find(15156).must_equal Bank::Account.all[-1]
    end

    it "Raises an error for an account that doesn't exist" do
      Bank::Account.find(12345)
      proc {
        account.deposit(deposit_amount)
        }.must_raise ArgumentError
    end

  end
end
