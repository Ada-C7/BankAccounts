require_relative './account'
require 'csv'

module Bank
    class CheckingAccount < Account
        attr_accessor :id, :balance

        def initialize(_id, _balance)
            @id = _id
            @balance = _balance
            @used_checks = 0
            super(_id, _balance)
            raise ArgumentError, 'Must deposit at least $10' if @balance.to_f < 9
        end

        def withdraw(amt)
            super(amt)
            if @balance.to_f < 0
                puts 'Account balance cannot drop below $10'
            else
                @balance -= 1
            end
        end

        def withdraw_using_check(amt)
            raise ArgumentError, 'Cannot withdraw negative number' if amt < 0
            if @balance - amt < -10
                puts 'Your account balance cannot drop below -$10'
            elsif @used_checks >= 3
                puts 'You will be charged a transaction fee'
                @balance -= amt + 2
                @used_checks += 1
            else
                @balance -= amt
                @used_checks += 1
            end
            @balance
        end

        def reset_checks
            @used_checks = 0
        end
    end
  end
