#creates a new subclass of Account class that is
require_relative 'account.rb'
module Bank
    class CheckingAccount < Account
        attr_reader :minimum, :fee
        def initialize (id, balance, opendate = nil)
            #super sets the instance variables found in the Account initialize method
            super
        end


        #method which returns 1, so fee for any object in checking account is now 1
        def fee
            1
        end

        #method which returns 0 for the minimum for a checking account is now 0
        def minimum
            0
        end


        # def withdraw_using_check
        #
        # end
        #
        # def reset_checks
        #
        # end
    end

end
