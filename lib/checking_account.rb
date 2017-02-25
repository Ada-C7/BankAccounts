require 'csv'
require_relative 'account'

module Bank

     class CheckingAccount < Account

          attr_reader :counter, :check_withdrawal_fee

          def initialize(id, balance, date_opened = nil)

               super
               @counter = 0
               @check_withdrawal_fee

          end

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

          def withdraw_with_check(withdrawal_amount)

               raise ArgumentError.new "Please enter a withdrawal amount greater than 0." unless withdrawal_amount > 0

               @counter += 1
               deficit_limit = 10

               if (1..3) === @counter then @check_withdrawal_fee = 0; end
               if (4..10000) === @counter then @check_withdrawal_fee = 2; end

               if @balance - (withdrawal_amount + @check_withdrawal_fee) >= -deficit_limit
                    @balance -= (withdrawal_amount + @check_withdrawal_fee)

               else
                    puts "You haven't sufficient funds for withdrawal."
                    @balance

               end

          end

          def reset_checks

               @counter = 0

          end

     end

end



#The user is allowed three free check uses in one month, but any subsequent use adds a $2 transaction fee

#reset_checks: Resets the number of checks used to zero
#
janice = Bank::CheckingAccount.new(333, 300)

withdrawal_amount = 3

# 2.times do
#
#      janice.withdraw_with_check(withdrawal_amount)
#      puts janice.counter
#      puts janice.balance
#      puts janice.check_withdrawal_fee
#
# end
#
# janice.reset_checks
#
# puts janice.reset_checks.class
#
# puts "Reset: #{janice.reset_checks}"
#
# 2.times do
#
#      janice.withdraw_with_check(withdrawal_amount)
#      puts janice.counter
#      puts janice.balance
#      puts janice.check_withdrawal_fee
#
# end
