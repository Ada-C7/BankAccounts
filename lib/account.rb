
module Bank
    class Account
        attr_accessor :id, :balance, :withdraw, :deposit

        def initialize (id, balance)
            #need to call a method here that checks if balance is > 0; argument error
            @id = id
            @balance = balance
            @withdraw
            @deposit
        end

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

        def deposit(deposit_amount)
            @deposit = deposit_amount
            if deposit_amount > 0
                @balance += @deposit
                return @balance
            else
                raise ArgumentError.new("You need to enter a positive amount to deposit")
            end
        end

        # def new_account_check
        #     #make sure that new accounts are not started with negative balance
        # end


        # def show_balance
        #     puts "Your balance is: $#{@balance}"
        # end

    end

end

my_account = Bank::Account.new(16, 1000)
# puts my_account.withdraw(200)
puts my_account.deposit(200)
