#creates a new subclass of Account class that is
require_relative 'account.rb'
module Bank
    class CheckingAccount < Account
        attr_reader :minimum, :fee
        def initialize (id, balance, opendate = nil)
            @fee
            @minimum
            #super sets the instance variables found in the Account initialize method
            super
        end



        def withdraw(amount)
            #fee of $1 for each withdraw
            # super
            @fee = 1
            @minimum = 0
            # @balance -=fee
            # return @balance

            #display new balance
            #balance can't go below -10 including fee
            #if below -10 PUTS message
            #if enter negative withdraw amount PUTS message

        end


        def withdraw_using_check

        end

        def reset_checks

        end







    end







end
