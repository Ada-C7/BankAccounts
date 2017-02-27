require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'

describe 'CheckingAccount' do
    describe '#initialize' do
        # Check that a CheckingAccount is in fact a kind of account
        it 'Is a kind of Account' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            account.must_be_kind_of Bank::Account
        end
    end

    describe '#withdraw' do
        it 'Applies a $1 fee each time' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            account.withdraw(0)
            account.balance.must_equal 99
        end

        it "Doesn't modify the balance if the fee would put it negative" do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            account.withdraw(100)
            account.balance.must_equal account.balance
        end
    end

    describe '#withdraw_using_check' do
        it 'Reduces the balance' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            account.withdraw_using_check(50)
            account.balance.must_equal 50
        end

        it 'Returns the modified balance' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            result = account.withdraw_using_check(50)
            result.must_equal 50
        end

        it 'Allows the balance to go down to -$10' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            account.withdraw_using_check(110)
            account.balance.must_equal -10
        end

        it 'Outputs a warning if the account would go below -$10' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            proc { account.withdraw_using_check(111) }.must_output /.+/
        end

        it "Doesn't modify the balance if the account would go below -$10" do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            account.withdraw_using_check(111)
            account.balance.must_equal account.balance
        end

        it 'Requires a positive withdrawal amount' do
            account = Bank::CheckingAccount.new(12_345, 100)

            proc do
                account.withdraw_using_check(-25)
            end.must_raise ArgumentError
        end

        it 'Allows 3 free uses' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            3.times do
                account.withdraw_using_check(10)
            end
            account.balance.must_equal 70
        end

        it 'Applies a $2 fee after the third use' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            4.times do
                account.withdraw_using_check(10)
            end
            account.balance.must_equal 58
        end
    end

    describe '#reset_checks' do
        it 'Can be called without error' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            account.must_respond_to :reset_checks
        end

        it 'Makes the next three checks free if less than 3 checks had been used' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            2.times do
                account.withdraw_using_check(10)
            end
            account.reset_checks
            2.times do
                account.withdraw_using_check(10)
            end
            account.balance.must_equal 60
        end

        it 'Makes the next three checks free if more than 3 checks had been used' do
            account = Bank::CheckingAccount.new(12_345, 100.0)
            4.times do
                account.withdraw_using_check(10)
            end
            account.reset_checks
            account.withdraw_using_check(10)

            account.balance.must_equal 48
        end
    end
end
