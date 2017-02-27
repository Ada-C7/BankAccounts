require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

describe "Owner Test Set" do
  describe "Owner#initialize" do
    it "Is a kind of Owner" do
      account = Bank::Owner.new(14, "Morales", "Wanda", "9003 Gerald Hill", "Honolulu", "Hawaii")
      account.must_be_kind_of Bank::Account
    end

    it "Takes in an ID, last_name, first_name, street, city, zip, state" do
      id = 14
      last_name = "Morales"
      first_name = "Wanda"
      street = "9003 Gerald Hill"
      city = "Honolulu"
      state = "Hawaii"
      account = Bank::Account.new(id, last_name, first_name, street, city, state, state)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :last_name
      account.id.must_equal last_name

      account.must_respond_to :first_name
      account.id.must_equal first_name

      account.must_respond_to :street
      account.id.must_equal street

      account.must_respond_to :city
      account.id.must_equal city

      account.must_respond_to :state
      account.id.must_equal state
    end

    # it "owner_id must be a positive integer"
    # it "state must be a valid state"
  end

#################
  describe "Ownder#withdraw" do
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
      }.must_output /.+/
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
    # THIS IS THE PART THAT'S STILL NOT WORKING!!!!
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

# TODO: change 'xdescribe' to 'describe' to run these tests
xdescribe "Wave 2" do
  describe "Account.all" do
    it "Returns an array of all accounts" do
      # account1 = Bank::Account.new(1337, 100.0)
      # account2 = Bank::Account.new(1221, 25.0)
      # account3 = Bank::Account.new(1442, 125.0)
      # all_accounts =
      # TODO: Your test code here!
      # Useful checks might include:
      #   - Account.all returns an array
      #   - Everything in the array is an Account
      #   - The number of accounts is correct
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file
      # Feel free to split this into multiple tests if needed
    end
  end

  describe "Account.find" do
    it "Returns an account that exists" do
      # TODO: Your test code here!
    end

    it "Can find the first account from the CSV" do
      # TODO: Your test code here!
    end

    it "Can find the last account from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for an account that doesn't exist" do
      # TODO: Your test code here!
    end
  end
end
