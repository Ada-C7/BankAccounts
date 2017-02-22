
module Bank
    class Account
        attr_accessor :id, :balance

        def initialize (id, balance)
            @id = id
            @balance = balance
        end

        def show_balance
            puts "Your balance is: $#{@balance}"
        end

    end

end

my_account = Bank::Account.new(16, 1000)
my_account.show_balance
