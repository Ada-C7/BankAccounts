require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/savings_account'

describe 'SavingsAccount' do
    describe '#initialize' do
        it 'Is a kind of Account' do
            # Check that a SavingsAccount is in fact a kind of account
            account = Bank::SavingsAccount.new(12_345, 100.0)
            account.must_be_kind_of Bank::Account
        end

        it 'Requires an initial balance of at least $10' do
            proc { account = Bank::SavingsAccount.new(12_345, 2) }.must_raise ArgumentError
        end
    end

    describe '#withdraw' do
        it 'Applies a $2 fee each time' do
            account = Bank::SavingsAccount.new(12_345, 100.0)
            account.withdraw(0)
            account.balance.must_equal 98
        end

        it 'Outputs a warning if the balance would go below $10' do
            account = Bank::SavingsAccount.new(12_345, 100.0)
            proc { account.withdraw(97) }.must_output /.+/
        end

        it "Doesn't modify the balance if it would go below $10" do
            account = Bank::SavingsAccount.new(12_345, 100.0)
            account.withdraw(97)
            account.balance.must_equal account.balance
        end

        it "Doesn't modify the balance if the fee would put it below $10" do
            account = Bank::SavingsAccount.new(12_345, 100.0)
            account.withdraw(90)
            account.balance.must_equal account.balance
        end
    end

    describe '#add_interest' do
        it 'Returns the interest calculated' do
            account = Bank::SavingsAccount.new(12_345, 100.0)
            account_balance = account.add_interest(25)
            interest = account_balance - Bank::SavingsAccount.new(12_345, 100.0).balance
            interest.must_equal 25
        end

        it 'Updates the balance with calculated interest' do
            account = Bank::SavingsAccount.new(12_345, 100.0)
            account.add_interest(25).must_equal 125
        end

        it 'Requires a positive rate' do
            account = Bank::SavingsAccount.new(12_345, 100.0)
            proc { account.add_interest(-25) }.must_raise ArgumentError
        end
    end
end
