require 'csv'

module Bank

     class Account

          def self.all(file)

               all_accounts = []

               CSV.open(file).each do | line |

                    id = line[0].to_i
                    balance = line[1].to_i
                    date_opened = line[2]

                    account = Account.new(id, balance, date_opened)

                    all_accounts << account
               end

               all_accounts
          end

          def self.find(file, id)

               all_accounts = Bank::Account.all(file)

               all_accounts.each do | account |

                    if account.id == id

                         return account

                    end

               end

               raise ArgumentError.new "Account #{id} does not exist."

          end

          def self.find_with_index(file, index)

               all_accounts = Bank::Account.all(file)

               all_accounts.fetch(index)
               
          end


          attr_accessor :id, :balance, :date_opened

          def initialize(id, balance, date_opened = nil)

               raise ArgumentError.new "Can't create an account with a negative balance." unless balance >= 0

               @id = id
               @balance = balance
               @date_opened = date_opened

          end

          def withdraw(withdrawal_amount)

               raise ArgumentError.new "Please enter a withdrawal amount greater than 0." unless withdrawal_amount > 0

               if @balance >= withdrawal_amount
                    @balance -= withdrawal_amount

               else
                    puts "You haven't sufficient funds for withdrawal."
                    @balance

               end

          end

          def deposit(deposit_amount)

               raise ArgumentError.new "Please enter a deposit amount greater than 0." unless deposit_amount > 0

               @balance += deposit_amount

          end


     end

end

find_account = Bank::Account.find("../support/accounts.csv", 1213)
puts find_account
puts find_account.class
