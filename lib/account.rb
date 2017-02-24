require 'csv'

module Bank

     class Account

          def self.all(file)

               all_accounts = []

               CSV.open(file).each do | line |

                    account = Account.new(line[0].to_i, line[1].to_i)

                    all_accounts << account
               end

               all_accounts
          end

          def self.find_with_id(file, inquiry) # using ID

               all_accounts = Bank::Account.all(file)
               found = ""

               all_accounts.each do | account |


                    if account.id == inquiry

                         found = account
                    end


               end

               found


          end

          def self.find_with_index(file, inquiry) # using index in array

               all_accounts = Bank::Account.all(file)

               found = all_accounts[inquiry]

               raise ArgumentError.new "Can't create an account with a negative balance." if found == nil

               found

          end

          attr_accessor :id, :balance

          def initialize(id,balance)

               @id = id

               if balance >= 0
                    @balance = balance

               else
                    raise ArgumentError.new "Can't create an account with a negative balance."

               end

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

          def deposit(deposit_amount)

               if deposit_amount >= 0

                    start_balance = @balance

                    @balance = start_balance + deposit_amount

               else
                    raise ArgumentError.new "Withdrawal amounts must be positive."

               end


          end


     end

end

# new_account = Bank::Account.new(133, 100, hash)

# puts new_account.balance

# puts new_account.owner.name

# puts new_account.owner.phone

# expected_balance = new_account.withdraw(25)

# puts expected_balance
#
# all_accounts = Bank::Account.all("../support/accounts.csv")

#find_account = Bank::Account.find("../support/accounts.csv", 1213)
