module Bank
    class Account
        attr_reader :id, :balance

        def initialize(id, balance)
            raise ArgumentError, 'balance must be >= 0' if balance < 0

            @id = id
            @balance = balance
        end

        def withdraw(amt)
            raise ArgumentError, 'Cannot withdraw negative number' if amt < 0
            if @balance - amt < 0
                puts 'You cannot withdraw more than your account balance'
            else
                @balance -= amt
            end
            @balance
        end

        def deposit(amt)
            raise ArgumentError, 'Cannot deposit negative number' if amt < 0
            @balance += amt
            @balance
        end
    end
end
