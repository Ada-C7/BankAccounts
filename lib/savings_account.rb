require_relative 'account.rb'

module Bank
    class SavingsAccount < Account
        def initialize (id, balance, opendate = nil)
        raise ArgumentError.new("You must have at least $10") if balance < 10
        super
        end



    def withdraw (amount)
        #inherit withdraw functionality from Account
        #can not go below $10
        fee = 2
        if @balance - amount < 10
            puts "You don't have enough in your account for this"
            return @balance
        elsif @balance - (amount + fee) < 10
            puts "The transaction fee would make you go under $10"
            return @balance
        else
        #incur $2 fee each transaction
        super
        @balance -=fee
        return @balance
        end

    end

    def add_interest(rate)
        interest = @balance * rate/100
        @balance += interest
        return interest
    end

    # return @balance


# account = Bank::SavingsAccount.new(116,10000)
# puts account.add_interest(0.25)








    end
end
