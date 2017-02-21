module Bank

     class Account

          attr_accessor :id, :balance, :start_balance

          def initialize(id, balance)

               @id = id

               if balance >= -
                    @balance = balance

               else
                    raise ArgumentError.new "Can't create an account with a negative balance."

               end

               @start_balance

          end

          def withdraw(withdrawal_amount)

               start_balance = @balance
               @balance = start_balance - withdrawal_amount

               if @balance >= 0 
                    @balance
               else
                    puts "Your balance is now negative."

               end

          end

     end

end


# new_account = Bank::Account.new(133, 100)
#
# puts new_account.balance
#
# expected_balance = new_account.withdraw(25)
#
# puts expected_balance
