require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'

describe "Wave 1" do
  describe "Account#initialize" do
    it "Takes an ID, an initial balance, and date created" do
      id = 1337
      balance = 100.0

      account = Bank::Account.new(id, balance)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

    end

    it "Raises an ArgumentError when created with a negative balance" do

      proc {
        Bank::Account.new(1337, -100.0)
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do

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


      proc {
        account.withdraw(withdrawal_amount)
      }.must_output(/.+/)
    end

    it "Doesn't modify the balance if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

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
end

describe "Wave 2" do
  describe "Account.all" do
    before do
      @spec_accounts = Bank::Account.all
    end
    it "Accounts.all returns an array" do
      @spec_accounts.class.must_equal Array, "This is not an array"
    end

    it "Everything in the array is an Account" do
      @spec_accounts.each do |account|
      account.must_be_instance_of Bank::Account
        end
      end

      it "The number of accounts is correct" do
        @spec_accounts.length.must_equal 12
      end

      it "The ID and balance of the first and last accounts match" do
        @spec_accounts[0].id.must_equal 1212, "Oops this should match the id, but it doesn't"
        @spec_accounts[0].balance.must_equal 1235667, "Rurow, this should match the balance, but it doesn't"

        @spec_accounts[11].id.must_equal 15156, "Oops this should match the id, but it doesn't"
        @spec_accounts[11].balance.must_equal 4356772, "Rurow, this should match the balance, but it doesn't"
      end
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      sample_account = Bank::Account.find(1212)
      sample_account.must_be_instance_of Bank::Account
      sample_account.id.must_equal 1212
    end

    it "Can find the first account from the CSV" do
      first_account = Bank::Account.find(1212)
      first_account.must_be_instance_of Bank::Account
      first_account.id.must_equal 1212
    end

    it "Can find the last account from the CSV" do
      last_account = Bank::Account.find(15156)
      last_account.must_be_instance_of    Bank::Account
      last_account.id.must_equal 15156
    end

    it "Raises an error for an account that doesn't exist" do
      proc {
        Bank::Account.find(12345678)
      }.must_raise ArgumentError
    end
  end
