require 'csv'
require_relative 'account'

module Bank

     class CheckingAccount < Account

          def withdraw(withdrawal_amount)

               raise ArgumentError.new "Please enter a withdrawal amount greater than 0." unless withdrawal_amount > 0
               
               withdrawal_fee = 1

               if @balance >= withdrawal_amount + withdrawal_fee
                    @balance -= (withdrawal_amount + withdrawal_fee)

               else
                    puts "You haven't sufficient funds for withdrawal."
                    @balance

               end

          end



     end

end

#withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.

#Allows the account to go into overdraft up to -$10 but not any lower

#The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee

#reset_checks: Resets the number of checks used to zero
#
# janice = Bank::CheckingAccount.new(333, 300)
#
# puts janice.withdraw(1)
# puts janice.balance
