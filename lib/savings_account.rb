require 'csv'
require_relative 'account'

module Bank

     class SavingsAccount < Account

          def initialize(id, balance)

               raise ArgumentError.new "Starting balance must be $10 or more." until balance >= 10
               super


          end

          def withdraw(withdrawal_amount)

               raise ArgumentError.new "Please enter a withdrawal amount greater than 0." unless withdrawal_amount > 0

               fee = 2

               if @balance - (withdrawal_amount + fee) >= 12
                    @balance -= (withdrawal_amount + fee)

               else
                    puts "You haven't sufficient funds for withdrawal."
                    return @balance

               end

          end


     end

end


#Updated withdrawal functionality:
#Each withdrawal 'transaction' incurs a fee of $2 that is taken out of the balance.
#Does not allow the account to go below the $10 minimum balance - Will output a warning #message and return the original un-modified balance
#It should include the following new method:

#add_interest(rate): Calculate the interest on the balance and add the interest to the balance. Return the interest that was calculated and added to the balance (not the updated balance).
#Input rate is assumed to be a percentage (i.e. 0.25).
#The formula for calculating interest is balance * rate/100
#Example: If the interest rate is 0.25 and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.

# janice = Bank::SavingsAccount.new(333, 60)
