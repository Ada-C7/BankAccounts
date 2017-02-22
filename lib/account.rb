module Bank

     class Account

          attr_accessor :id, :balance, :start_balance

          def initialize(id, balance)

               @id = id

               if balance >= 0
                    @balance = balance

               else
                    raise ArgumentError.new "Can't create an account with a negative balance."

               end

               @start_balance

          end

          def withdraw(withdrawal_amount)

               if withdrawal_amount >= 0

                    start_balance = @balance

                    if start_balance >= withdrawal_amount
                         @balance = start_balance - withdrawal_amount

                    else
                         puts "Your balance is now negative."
                         @balance

                    end

               else
                    raise ArgumentError.new "Withdrawal amounts must be positive."

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
