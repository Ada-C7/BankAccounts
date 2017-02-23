#this is the new, second try at this

module Bank
    attr_accessor :id, :balance

    class Account
        def initialize (id, balance)
        raise ArgumentError.new("You need some positive cash flow to open an account") if balance < 0
        @id = id
        @balance = balance
        end

        def withdraw (amount)
            if amount > 0
                if @balance - amount < 0
                    raise ArgumentError.new ("You do not have enough money to withdraw this amount")
                end
                @balance -=amount
                return @balance
            else
                "You can only withdraw a positive amount of money"
            end
        end


        def deposit (amount)
            if amount > 0
                @balance +=amount
                return @balance
            end
        end


        def show_balance
            return @balance
        end

    end
end


my_account = Bank::Account.new(16, 1000)
# puts my_account.show_balance
puts my_account.withdraw(0)
# puts my_account.deposit(200)
