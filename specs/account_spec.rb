require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'
require_relative '../lib/owner'

describe "Wave 1" do

  # before do
  #   owner1_test = { :name => "Sally Mae", :address => "1234 Some Street, Seattle, WA 98144", :account_type => :checking }
  #
  #   new_owner = Bank::Owner.new(owner1_test)
  # end

  describe "Account#initialize" do

    # before do
    #   owner1_test = { :name => "Sally Mae", :address => "1234 Some Street, Seattle, WA 98144", :account_type => :checking }
    #
    #   new_owner = Bank::Owner.new(owner1_test)
    # end

    it "Takes an ID and an initial balance" do
      id = 1337
      balance = 100.0
      # owner1_test = { :name => "Sally Mae", :address => "1234 Some Street, Seattle, WA 98144", :account_type => :checking }
      #
      # new_owner = Bank::Owner.new(owner1_test)
      account = Bank::Account.new(id, balance)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance

      # account.must_respond_to :owner
      # account.owner.must_equal new_owner
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

    # before do
    #   owner1_test = { :name => "Sally Mae", :address => "1234 Some Street, Seattle, WA 98144", :account_type => :checking }
    #
    #   new_owner = Bank::Owner.new(owner1_test)
    # end

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

    # before do
    #   owner1_test = { :name => "Sally Mae", :address => "1234 Some Street, Seattle, WA 98144", :account_type => :checking }
    #
    #   new_owner = Bank::Owner.new(owner1_test)
    # end


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

#
# describe "Wave 1 - optional" do
#
#   describe "Owner#initialize" do
#     it "takes owner info as hash" do
#       owner1_test = { :name => "Sally Mae", :address => "1234 Some Street, Seattle, WA 98144", :account_type => :checking }
#       new_owner = Bank::Owner.new(owner1_test)
#
#       new_owner.must_respond_to :name
#       new_owner.name.must_equal owner1_test[:name]
#
#       new_owner.must_respond_to :address
#       new_owner.address.must_equal owner1_test[:address]
#
#       new_owner.must_respond_to :account_type
#       new_owner.account_type.must_equal owner1_test[:account_type]
#     end
#   end
#
#   describe "Account#initialize" do
#     it "Takes an ID, initial balance, and owner_info" do
#       id = 1337
#       balance = 100.0
#       owner2_test = { :name => "Jim Bob", :address => "5678 Some Street, Seattle, WA 98109", :account_type => :savings }
#       account = Bank::Account.new(id, balance)
#
#       account.must_respond_to :id
#       account.id.must_equal id
#
#       account.must_respond_to :balance
#       account.balance.must_equal balance
#
#       account.owner_name.must_respond_to :name
#       acount.owner_name.must_equal Bank::Owner.name
#     end
#   end
#
#
# end



# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  before do

      @account_array = Bank::Account.all
  end

  describe "Account.all" do
    it "Returns an array of all accounts" do


      # TODO: Your test code here!
      # Useful checks might include:
      #   - Account.all returns an array


      @account_array.class.must_equal Array
    end
    #   - Everything in the array is an Account

    # account_array.each do |element|
    #   element.class
    # end

    it "Everything in array is an Account" do
      @account_array.each do |element|
        element.must_be_instance_of Bank::Account
    end
  end

    it "The number of accounts matches number of lines in csv file" do  #   - The number of accounts is correct
      @account_array.length.must_equal 12
    end


    it "ID/balance of first and last accounts match csv file" do
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file

      first_account_id = @account_array[0].id
      first_account_balance = @account_array[0].balance

      first_account_id.must_equal "1212"
      first_account_balance.must_equal 1235667

      last_account_id = @account_array[-1].id
      last_account_balance = @account_array[-1].balance

      last_account_id.must_equal "15156"
      last_account_balance.must_equal 4356772
    end

      # Feel free to split this into multiple tests if needed

  end


  describe "Account.find" do


    it "Returns an account that exists" do



        # account_id = @account_array[3].id
        #
        Bank::Account.find("1215").must_equal "1215"


      # TODO: Your test code here!
    end

    it "Can find the first account from the CSV" do

      Bank::Account.find(Bank::Account.all[0].id).must_equal "1212"


      # TODO: Your test code here!
    end

    it "Can find the last account from the CSV" do

      Bank::Account.find(Bank::Account.all[-1].id).must_equal "15156"

      # TODO: Your test code here!
    end

    it "Raises an error for an account that doesn't exist" do

      proc {
        Bank::Account.find("00000")
      }.must_raise ArgumentError

      # TODO: Your test code here!
    end
  end
end
