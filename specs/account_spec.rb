require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'

Minitest::Reporters.use!

# #describe "Wave 1" do
#      before do
#           @hash = {name: "Janice", phone: "303-349-1433"}
#           @id = 1337
#           @balance = 100.0
#           @account = Bank::Account.new(@id, @balance, @hash)
#      end
#   describe "Account#initialize" do
#     it "Takes an ID, an initial balance and account owner" do
#
#       @account.must_respond_to :id
#       @account.id.must_equal @id
#
#       @account.must_respond_to :balance
#       @account.balance.must_equal @balance
#
#       @account.must_respond_to :owner
#       @account.owner.name.must_equal @hash[:name]
#       @account.owner.phone.must_equal @hash[:phone]
#
#     end
#
#     it "Raises an ArgumentError when created with a negative balance" do
#       # Note: we haven't talked about procs yet. You can think
#       # of them like blocks that sit by themselves.
#       # This code checks that, when the proc is executed, it
#       # raises an ArgumentError.
#       proc {
#            @hash
#            Bank::Account.new(@id, -100.0, @hash)
#       }.must_raise ArgumentError
#
#
#     end
#
#     it "Can be created with a balance of 0" do
#       # If this raises, the test will fail. No 'must's needed!
#       @hash
#       Bank::Account.new(@id, 0, @hash)
#     end
#   end
#
#  # describe "Account#withdraw" do
#     it "Reduces the balance" do
#       hash = {name: "Janice", phone: "303-349-1433"}
#       start_balance = 100.0
#       withdrawal_amount = 25.0
#       account = Bank::Account.new(1337, start_balance, hash)
#
#       account.withdraw(withdrawal_amount)
#
#       expected_balance = start_balance - withdrawal_amount
#       account.balance.must_equal expected_balance
#     end
#
#     it "Returns the modified balance" do
#       hash = {name: "Janice", phone: "303-349-1433"}
#       start_balance = 100.0
#       withdrawal_amount = 25.0
#       account = Bank::Account.new(1337, start_balance, hash)
#
#       updated_balance = account.withdraw(withdrawal_amount)
#
#       expected_balance = start_balance - withdrawal_amount
#       updated_balance.must_equal expected_balance
#     end
#
#     #it "Outputs a warning if the account would go negative" do
#       hash = {name: "Janice", phone: "303-349-1433"}
#       start_balance = 100.0
#       withdrawal_amount = 200.0
#       account = Bank::Account.new(1337, start_balance, hash)
#
#       # Another proc! This test expects something to be printed
#       # to the terminal, using 'must_output'. /.+/ is a regular
#       # expression matching one or more characters - as long as
#       # anything at all is printed out the test will pass.
#       proc {
#         account.withdraw(withdrawal_amount)
#       }.must_output /.+/
#     end
#
#     #it "Doesn't modify the balance if the account would go negative" do
#       hash = {name: "Janice", phone: "303-349-1433"}
#       start_balance = 100.0
#       withdrawal_amount = 200.0
#       account = Bank::Account.new(1337, start_balance, hash)
#
#       updated_balance = account.withdraw(withdrawal_amount)
#
#       # Both the value returned and the balance in the account
#       # must be un-modified.
#       updated_balance.must_equal start_balance
#       account.balance.must_equal start_balance
#     end
#
#     it "Allows the balance to go to 0" do
#       hash = {name: "Janice", phone: "303-349-1433"}
#       account = Bank::Account.new(1337, 100.0, hash)
#       updated_balance = account.withdraw(account.balance)
#       updated_balance.must_equal 0
#       account.balance.must_equal 0
#     end
#
#     it "Requires a positive withdrawal amount" do
#       hash = {name: "Janice", phone: "303-349-1433"}
#       start_balance = 100.0
#       withdrawal_amount = -25.0
#       account = Bank::Account.new(1337, start_balance, hash)
#
#       proc {
#         account.withdraw(withdrawal_amount)
#       }.must_raise ArgumentError
#     end
#   end
#
#   describe "Account#deposit" do
#     it "Increases the balance" do
#       hash = {name: "Janice", phone: "303-349-1433"}
#       start_balance = 100.0
#       deposit_amount = 25.0
#       account = Bank::Account.new(1337, start_balance, hash)
#
#       account.deposit(deposit_amount)
#
#       expected_balance = start_balance + deposit_amount
#       account.balance.must_equal expected_balance
#     end
#
#     it "Returns the modified balance" do
#       hash = {name: "Janice", phone: "303-349-1433"}
#       start_balance = 100.0
#       deposit_amount = 25.0
#       account = Bank::Account.new(1337, start_balance, hash)
#
#       updated_balance = account.deposit(deposit_amount)
#
#       expected_balance = start_balance + deposit_amount
#       updated_balance.must_equal expected_balance
#     end
#
#     it "Requires a positive deposit amount" do
#       hash = {name: "Janice", phone: "303-349-1433"}
#       start_balance = 100.0
#       deposit_amount = -25.0
#       account = Bank::Account.new(1337, start_balance, hash)
#
#       proc {
#         account.deposit(deposit_amount)
#       }.must_raise ArgumentError
#     end
#   end
# end

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do
    it "Returns an array of all accounts" do

         hash = {name: "Janice", phone: "303-349-1433"}
         all_accounts = Bank::Account.all("../support/accounts.csv", hash)
         all_accounts.must_be_kind_of Array

    end

    it "The number of accounts is correct" do

         hash = {name: "Janice", phone: "303-349-1433"}
         all_accounts = Bank::Account.all("../support/accounts.csv", hash)
         all_accounts.length.must_equal 12

    end

    it "Everything in the array is an Account" do

         hash = {name: "Janice", phone: "303-349-1433"}
         all_accounts = Bank::Account.all("../support/accounts.csv", hash)

         all_accounts.each do | account |

             account.must_be_kind_of Bank::Account

        end

    end

    it "The ID and balance of the first and last accounts match what's in the CSV file" do

         hash = {name: "Janice", phone: "303-349-1433"}
         all_accounts = Bank::Account.all("../support/accounts.csv", hash)

         all_accounts[0].id.must_equal 1212
         all_accounts[-1].id.must_equal 15156
         all_accounts[0].balance.must_equal 1235667
         all_accounts[-1].balance.must_equal 4356772


     end

    end

      # TODO: Your test code here!
      # Useful checks might include:
      #   ✓ Account.all returns an array
      #   - Everything in the array is an Account
      #   ✓  The number of accounts is correct
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file
      # Feel free to split this into multiple tests if needed



  xdescribe "Account.find" do
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
