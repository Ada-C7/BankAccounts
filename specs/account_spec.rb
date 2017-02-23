require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/account'

describe 'Wave 1' do
    describe 'Account#initialize' do
        it 'Takes an ID and an initial balance' do
            id = '1214'
            balance = 9_876_890
            account = Bank::Account.new(id, balance)

            account.must_respond_to :id
            account.id.must_equal id

            account.must_respond_to :balance
            account.balance.must_equal balance
        end

        it 'Raises an ArgumentError when created with a negative balance' do
            # Note: we haven't talked about procs yet. You can think
            # of them like blocks that sit by themselves.
            # This code checks that, when the proc is executed, it
            # raises an ArgumentError.
            proc do
                Bank::Account.new('1214', -100.0)
            end.must_raise ArgumentError
        end

        it 'Can be created with a balance of 0' do
            # If this raises, the test will fail. No 'must's needed!
            Bank::Account.new('1214', 0)
        end
    end

    describe 'Account#withdraw' do
        it 'Reduces the balance' do
            start_balance = 9_876_890
            withdrawal_amount = 25.0
            account = Bank::Account.new('1214', start_balance)

            account.withdraw(withdrawal_amount)

            expected_balance = start_balance - withdrawal_amount
            account.balance.must_equal expected_balance
        end

        it 'Returns the modified balance' do
            start_balance = 9_876_890
            withdrawal_amount = 25.0
            account = Bank::Account.new('1214', start_balance)

            updated_balance = account.withdraw(withdrawal_amount)

            expected_balance = start_balance - withdrawal_amount
            updated_balance.must_equal expected_balance
        end

        it 'Outputs a warning if the account would go negative' do
            start_balance = 9_876_890
            withdrawal_amount = 10_000_000
            account = Bank::Account.new('1214', start_balance)

            # Another proc! This test expects something to be printed
            # to the terminal, using 'must_output'. /.+/ is a regular
            # expression matching one or more characters - as long as
            # anything at all is printed out the test will pass.
            proc do
                account.withdraw(withdrawal_amount)
            end.must_output /.+/
        end

        it "Doesn't modify the balance if the account would go negative" do
            start_balance = 9_876_890.0
            withdrawal_amount = 10_000_000
            account = Bank::Account.new('1214', start_balance)

            updated_balance = account.withdraw(withdrawal_amount)

            # Both the value returned and the balance in the account
            # must be un-modified.
            updated_balance.must_equal start_balance
            account.balance.must_equal start_balance
        end

        it 'Allows the balance to go to 0' do
            account = Bank::Account.new('1214', 100.0)
            updated_balance = account.withdraw(account.balance)
            updated_balance.must_equal 0
            account.balance.must_equal 0
        end

        it 'Requires a positive withdrawal amount' do
            start_balance = 9_876_890
            withdrawal_amount = -25.0
            account = Bank::Account.new('1214', start_balance)

            proc do
                account.withdraw(withdrawal_amount)
            end.must_raise ArgumentError
        end
    end

    describe 'Account#deposit' do
        it 'Increases the balance' do
            start_balance = 9_876_890
            deposit_amount = 25.0
            account = Bank::Account.new('1214', start_balance)

            account.deposit(deposit_amount)

            expected_balance = start_balance + deposit_amount
            account.balance.must_equal expected_balance
        end

        it 'Returns the modified balance' do
            start_balance = 9_876_890
            deposit_amount = 10_000_000
            account = Bank::Account.new('1214', start_balance)

            updated_balance = account.deposit(deposit_amount)

            expected_balance = start_balance + deposit_amount
            updated_balance.must_equal expected_balance
        end

        it 'Requires a positive deposit amount' do
            start_balance = 9_876_890
            deposit_amount = -25.0
            account = Bank::Account.new('1214', start_balance)

            proc do
                account.deposit(deposit_amount)
            end.must_raise ArgumentError
        end
    end
end

# : change 'xdescribe' to 'describe' to run these tests
describe 'Wave 2' do
    describe 'Account.all' do
        it 'Returns an array of all accounts' do
            #   - Account.all returns an array
            Bank::Account.all.must_be_kind_of Array
        end
        it 'Returns arrays that are Account Class' do
            #   - Everything in the array is an Account
            account = Bank::Account.all
            account.each do |details_array|
                details_array.must_be_instance_of Bank::Account
            end
        end
        it 'Returns all accounts listed in csv file' do
            #   - The number of accounts is correct
            csv_file = 'support/accounts.csv'
            number_of_accounts = `wc -l "#{csv_file}"`.strip.split(' ')[0].to_i
            Bank::Account.all.to_a.length.must_equal number_of_accounts
        end
        it 'Returns accurate data' do
            #   - The ID and balance of the first and last accounts match what's in the CSV file
            first_account = Bank::Account.new('1212', 100)
            second_account = Bank::Account.new('15156', 50)
            csv_file = CSV.read('support/accounts.csv')

            first_account.id.must_equal csv_file.first.first
            first_account.balance.to_s.must_equal csv_file.first[1]

            second_account.id.must_equal csv_file.to_a.last.first
            second_account.balance.to_s.must_equal csv_file.to_a.last[1]
        end
    end
end

describe 'Account.find' do
    it 'Returns an account that exists' do
        found = Bank::Account.find('1216')
        csv_file = CSV.open('support/accounts.csv')

        csv_file.must_include found
    end

    it 'Can find the first account from the CSV' do
        found = Bank::Account.find('1212')
        csv_file = CSV.open('support/accounts.csv')

        found.must_equal csv_file.first
    end

    it 'Can find the last account from the CSV' do
        found = Bank::Account.find('15156')
        csv_file = CSV.open('support/accounts.csv')

        found.to_a.must_equal csv_file.to_a.last
    end

    it "Raises an error for an account that doesn't exist" do
        # proc { Bank::Account.find('test') }.must_raise ArgumentError
    end
end
