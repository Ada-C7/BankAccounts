require_relative './account'
require 'csv'

module Bank
    class SavingsAccount < Account
        attr_accessor :id, :balance

        def initialize(_id, _balance)
            @id = _id
            @balance = _balance
            super(_id, _balance)
            raise ArgumentError, 'Must deposit at least $10' if @balance.to_f < 9
        end

        def withdraw(amt)
            super(amt)
            if @balance.to_f < 9
                puts 'Account balance cannot drop below $10'
            else
                @balance -= 2
            end
        end

        def add_interest(rate)
            raise ArgumentError, 'Interest rate must be positive' if rate < 0
            @balance *= (1 + (rate.to_f / 100))
        end
    end
end
