
module Bank
    class Account
        attr_accessor :id, :balance, :withdraw

        def initialize (id, balance)
            #need to call a method here that checks if balance is > 0; argument error
            @id = id
            @balance = balance
            @withdraw
        end

        def withdraw (withdraw_amount)
            @withdraw = withdraw_amount
            if @balance - @withdraw > 0
                puts "Here's your cash"
                @balance = @balance - @withdraw
                puts "Your new balance is: $#{@balance}"
            else
                puts "you do not have enough money in your account for this"
            end
        end

        def deposit
            #make sure positive
            #adjust balance
        end

        def new_account_check
            #make sure that new accounts are not started with negative balance
        end


        def show_balance
            puts "Your balance is: $#{@balance}"
        end

    end

end

my_account = Bank::Account.new(16, 1000)
# my_account.show_balance
my_account.withdraw(200)
