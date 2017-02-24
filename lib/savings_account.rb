require_relative 'account.rb'

module Bank
    class SavingsAccount < Account
        def initialize (id, balance, opendate = nil)
        raise ArgumentError.new("You must have at least $10") if balance < 10
        super
        end

    end
end
