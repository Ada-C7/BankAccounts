require_relative 'account.rb'

module Bank
    class SavingsAccount < Account
        def initialize (id, balance, opendate = nil)
        raise ArgumentError.new("You must have at least $10") if balance < 10
        super
        end


    def withdraw (amount)
        #inherit withdraw functionality from Account

        #incur $2 fee each transaction
        super
        @balance -=2
        return @balance

        #can not go below $10
    end











    end
end
