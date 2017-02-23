require 'csv'

module Bank

     class Owner

          attr_accessor :name, :phone

          def initialize(hash)

               @name = hash[:name]
               @phone = hash[:phone]

          end

     end

     class Account

          def self.all(file, hash)

               all_accounts = []

               CSV.open(file).each do | line |

                    account = Account.new(line[0].to_i, line[1].to_i, hash)

                    all_accounts << account
               end

               all_accounts
          end

          def self.find_account(file, id)

               CSV.open(file).each do | account |

                   account.id.include?(id)

              end

          end

          attr_accessor :id, :balance, :owner

          def initialize(id, balance, hash)

               @id = id

               # if balance >= 0
                    @balance = balance

               # else
               #      raise ArgumentError.new "Can't create an account with a negative balance."
               #
               # end

               @owner = Bank::Owner.new(hash)

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

hash = {name: "Janice", phone: "303-349-1433"}

# owner_1 = Bank::Owner.new(hash)

# puts owner_1.name

# puts owner_1.phone

# new_account = Bank::Account.new(133, 100, hash)

# puts new_account.balance

# puts new_account.owner.name

# puts new_account.owner.phone

# expected_balance = new_account.withdraw(25)

# puts expected_balance

# all_accounts = Bank::Account.all("../support/accounts.csv", hash)
#
# find_accounts = Bank::Account.find_account("../support/accounts.csv", 1213)
#
# puts find_accounts
