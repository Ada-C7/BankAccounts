require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

Minitest::Reporters.use!

describe "SavingsAccount" do

     describe "#initialize" do

          it "Is a kind of Account" do

                account = Bank::SavingsAccount.new(12345, 100.0)
                account.must_be_kind_of Bank::Account

         end

          it "Requires an initial balance of at least $10" do

              proc {Bank::SavingsAccount.new(1337, -100.0)}.must_raise ArgumentError

              proc {Bank::SavingsAccount.new(1337, -0.0)}.must_raise ArgumentError

              proc {Bank::SavingsAccount.new(1337, 9.0)}.must_raise ArgumentError

          end
     end

     describe "#withdraw" do

         it "Outputs a warning if the balance would go below $10" do

              start_balance = 50.0
              withdrawal_amount = 48.0
              account = Bank::SavingsAccount.new(1337, start_balance)

              proc {account.withdraw(withdrawal_amount)}.must_output /.+/

         end

         it "Doesn't modify the balance if it would go below $10" do

              start_balance = 50.0
              withdrawal_amount = 41.0
              account = Bank::SavingsAccount.new(1337, start_balance)

              updated_balance = account.withdraw(withdrawal_amount)
              updated_balance.must_equal start_balance
              account.balance.must_equal start_balance
         end

         it "Doesn't modify the balance if it would go below $10" do

              start_balance = 50.0
              withdrawal_amount = 41.0
              account = Bank::SavingsAccount.new(1337, start_balance)

              updated_balance = account.withdraw(withdrawal_amount)
              updated_balance.must_equal start_balance
              account.balance.must_equal start_balance
         end


         it "Doesn't modify the balance if it would go below $10 due to the $2 fee" do

             start_balance = 11
             withdrawal_amount = 1
             account = Bank::SavingsAccount.new(1337, start_balance)

             updated_balance = account.withdraw(withdrawal_amount)
             updated_balance.must_equal start_balance
             account.balance.must_equal start_balance

          end


     end

     describe "#add_interest" do

          it "Returns the interest calculated" do

              start_balance = 10000
              rate = 0.25
              account = Bank::SavingsAccount.new(1337, start_balance)
              calculated_interest = start_balance * (rate/100)

              calculated_interest.must_equal account.add_interest(rate)

          end

          it "Updates the balance with calculated interest" do

               start_balance = 12000
               rate = 0.13
               account = Bank::SavingsAccount.new(1337, start_balance)
               account.add_interest(rate)
               new_balance = start_balance * (1 + (rate/100))

               new_balance.must_equal account.balance

          end

          it "Requires a positive rate" do

               start_balance = 12000
               rate = -0.1
               account = Bank::SavingsAccount.new(1337, start_balance)

               proc {account.add_interest(rate)}.must_raise ArgumentError

          end

     end

end
