require_relative 'account.rb'

module Bank
    class SavingsAccount < Account
        def initialize (id, balance, opendate = nil)
        #raise error for insufficient balance
        super
        end

    end
end
