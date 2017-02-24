#creates a new subclass of Account class that is
require_relative 'account.rb'
module Bank
    class CheckingAccount < Account
        def initialize (id, balance, opendate = nil)
            #super sets the instance variables found in the Account initialize method
            super
        end




    end







end
