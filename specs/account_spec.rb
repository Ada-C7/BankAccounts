require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'

# describe "Wave 1" do
#   describe "Account#initialize" do
#     it "Takes an ID and an initial balance" do
#       id = 1337
#       balance = 100.0
#       account = Bank::Account.new(id, balance)
#
#       account.must_respond_to :id
#       account.id.must_equal id
#
#       account.must_respond_to :balance
#       account.balance.must_equal balance
#     end
#
#     it "Raises an ArgumentError when created with a negative balance" do
#       # Note: we haven't talked about procs yet. You can think
#       # of them like blocks that sit by themselves.
#       # This code checks that, when the proc is executed, it
#       # raises an ArgumentError.
#       proc {
#         Bank::Account.new(1337, -100.0)
#       }.must_raise ArgumentError
#     end
#
#     it "Can be created with a balance of 0" do
#       # If this raises, the test will fail. No 'must's needed!
#       Bank::Account.new(1337, 0)
#     end
#   end
#
#   describe "Account#withdraw" do
#     it "Reduces the balance" do
#       start_balance = 100.0
#       withdrawal_amount = 25.0
#       account = Bank::Account.new(1337, start_balance)
#
#       account.withdraw(withdrawal_amount)
#
#       expected_balance = start_balance - withdrawal_amount
#       account.balance.must_equal expected_balance
#     end
#
#     it "Returns the modified balance" do
#       start_balance = 100.0
#       withdrawal_amount = 25.0
#       account = Bank::Account.new(1337, start_balance)
#
#       updated_balance = account.withdraw(withdrawal_amount)
#
#       expected_balance = start_balance - withdrawal_amount
#       updated_balance.must_equal expected_balance
#     end
#
#     it "Outputs a warning if the account would go negative" do
#       start_balance = 100.0
#       withdrawal_amount = 200.0
#       account = Bank::Account.new(1337, start_balance)
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
#     it "Doesn't modify the balance if the account would go negative" do
#       start_balance = 100.0
#       withdrawal_amount = 200.0
#       account = Bank::Account.new(1337, start_balance)
#
#       updated_balance = account.withdraw(withdrawal_amount)
#
#       # Both the value returned and the balance in the account
#       # must be un-modified.
#       updated_balance.must_equal start_balance
#       account.balance.must_equal start_balance
#     end
#
#     it "Allows the balance to go to 0" do skip
#       account = Bank::Account.new(1337, 100.0)
#       updated_balance = account.withdraw(account.balance)
#       updated_balance.must_equal 0
#       account.balance.must_equal 0
#     end
#
#     it "Requires a positive withdrawal amount" do skip
#       start_balance = 100.0
#       withdrawal_amount = -25.0
#       account = Bank::Account.new(1337, start_balance)
#
#       proc {
#         account.withdraw(withdrawal_amount)
#       }.must_raise ArgumentError
#     end
#   end
#
#   describe "Account#deposit" do
#     it "Increases the balance" do
#       start_balance = 100.0
#       deposit_amount = 25.0
#       account = Bank::Account.new(1337, start_balance)
#
#       account.deposit(deposit_amount)
#
#       expected_balance = start_balance + deposit_amount
#       account.balance.must_equal expected_balance
#     end
#
#     it "Returns the modified balance" do
#       start_balance = 100.0
#       deposit_amount = 25.0
#       account = Bank::Account.new(1337, start_balance)
#
#       updated_balance = account.deposit(deposit_amount)
#
#       expected_balance = start_balance + deposit_amount
#       updated_balance.must_equal expected_balance
#     end
#
#     it "Requires a positive deposit amount" do
#       start_balance = 100.0
#       deposit_amount = -25.0
#       account = Bank::Account.new(1337, start_balance)
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
      new_account_info = Bank::Account.all  
    end
  end
end
#   - Account.all returns an array
describe "Account array" do
  it "returns something" do
    new_account_info = Bank::Account.all
    new_account_info.class.must_equal Array
    new_account_info.length.must_equal 12
  end
end


#   - Everything in the array is an Account
describe "Is it an account?" do
  it "verifies if it's an account" do
    new_account_info = Bank::Account.all
    #new_account_info.each do |acct_array|
    new_account_info[0].must_be_instance_of Bank::Account
  end
end

#   - The number of accounts is correct
describe "the number of accounts?" do
  it "Checks the length" do
    new_account_info = Bank::Account.all
    new_account_info.length.must_equal 12
  end
end

# #   - The ID and balance of the first and last
describe "check first and last" do
  it "Checks the ID & Balance of the first and last." do
    new_account_info = Bank::Account.all
    test_id = new_account_info[0].id
    test_balance = new_account_info[1].balance
    # new_account_info =
    # new_account_info
  end
end
# #       accounts match what's in the CSV file
# # Feel free to split this into multiple tests if needed
#
describe "checks random sample" do
  it "Checks account entry against csv file for a match" do
    new_account_info = Bank::Account.all
    accounts_master = CSV.read("../support/accounts.csv")
    lines = []
    accounts_master.each do |line|
      lines << line
    end
    lines[3][0].to_i.must_equal new_account_info[3].id.to_i
  end
end
#
#
describe "Account.find" do
   it "Returns an account that exists" do
    new_account_info = Bank::Account.all
    new_account_info.each do |line|
      return lines[0][0]
    end
  end
end

describe "Can find the first account from the CSV" do
  it "Found first account from csv" do
    accounts_master = CSV.read("../support/accounts.csv")
    lines = []
    accounts_master.each do |line|
      lines[0][0]
    end
  end
end
# # end
# #
describe "Can find the last account from the CSV" do
  it "Found first account from csv" do
    accounts_master = CSV.read("../support/accounts.csv")
    lines = []
    accounts_master.each do |line|
      lines.(0...lines.length)
    end
  end
end
# #
it "Raises an error for an account that doesn't exist" do
  # TODO: Your test code here!
end
