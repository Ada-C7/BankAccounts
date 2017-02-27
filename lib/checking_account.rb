#creates a new subclass of Account class that is
require_relative 'account.rb'
module Bank
    class CheckingAccount < Account
        def initialize (id, balance, opendate = nil)
            #super sets the instance variables found in the Account initialize method
            super
            @check_counter = 0
        end


        #method which returns 1, so fee for any object in checking account is now 1
        def fee
            1
        end

        #method which returns 0 for the minimum for a checking account is now 0
        def minimum
            0
        end



        def withdraw_using_check(amount)
            check_fee = 0

            if @check_counter >= 3
                check_fee = 2
            end

            if amount < 0
                puts "You must withdraw a positive amount"
            else
                if @balance - (amount + check_fee) < -10
                    puts "You do not have enough money in your account for this"
                else
                    @check_counter +=1
                    @balance -=(amount + check_fee)
                    return @balance
                end
            end
        end


        def reset_checks
            @check_counter = 0 
        end
    end

end
