
module Bank
    class Account
        attr_accessor :id, :balance, :withdraw, :deposit

        def initialize (id, balance)
            raise ArgumentError.new("You need some positive cash flow to open an account") if balance < 0
            @balance = balance
            @id = id
            @withdraw
            @deposit
        end




        #method to withdraw money
        def withdraw (withdraw_amount)
            @withdraw = withdraw_amount
            if @withdraw > 0
                if @balance - @withdraw >= 0
                    return @balance -= @withdraw
                    # return @balance
                else
                    puts "You don't have enough in your account for this"
                    return @balance
                end
            else
                raise ArgumentError.new("You must enter a positive withdraw amount")
            end
        end



        #method to deposit money
        def deposit(deposit_amount)
            @deposit = deposit_amount
            if deposit_amount > 0
                @balance += @deposit
                return @balance
            else
                raise ArgumentError.new("You need to enter a positive amount to deposit")
            end
        end



        #method to check balance at any time
        # def show_balance
        #     puts "Your balance is: $#{@balance}"
        # end



    end

end

# my_account = Bank::Account.new(16, -1000)
# puts my_account.withdraw(200)
# puts my_account.deposit(200)
