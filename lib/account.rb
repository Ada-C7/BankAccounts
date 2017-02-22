module Bank
    class Account
        attr_reader :id, :balance
        def initialize (id, balance)
            @id
            @balance
        end

        def show_balance
            return @balance
            puts "its working"

        end





    end

end

my_account = Bank::Account.new(16, 1000)
puts my_account.show_balance
