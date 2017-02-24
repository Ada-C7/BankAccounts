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
        raise ArgumentError.new("You must leave a balance of $10 in your account") if @balance - amount < 10 || @balance - (amount + fee) < 10

        #incur $2 fee each transaction
        super
        @balance -=fee
        return @balance

    end











    end
end
