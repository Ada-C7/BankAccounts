require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/checking_account'

Minitest::Reporters.use!

describe "CheckingAccount" do

     describe "#initialize" do

          it "Is a kind of Account" do

                account = Bank::CheckingAccount.new(12345, 100.0)
                account.must_be_kind_of Bank::Account

          end
     end

     describe "#withdraw" do

          it "Applies a $1 fee each time" do

               start_balance = 300
               withdrawal_amount = 298
               withdrawal_fee = 1
               account = Bank::CheckingAccount.new(12345, start_balance)

               account.withdraw(withdrawal_amount).must_equal start_balance - (withdrawal_amount +withdrawal_fee)

          end

          it "Doesn't modify the balance if the fee would put it negative" do

               start_balance = 300
               withdrawal_amount = 300
               withdrawal_fee = 1
               account = Bank::CheckingAccount.new(12345, start_balance)
               account.withdraw(withdrawal_amount)

               account.withdraw(withdrawal_amount).must_equal start_balance

          end

     end

     describe "#withdraw_with_check" do

          it "Reduces the balance" do

              start_balance = 300
              withdrawal_amount = 100
              account = Bank::CheckingAccount.new(12345, start_balance)
              account.withdraw_with_check(withdrawal_amount)

              account.balance.must_equal start_balance - withdrawal_amount

          end

          it "Returns the modified balance" do

               start_balance = 300
               withdrawal_amount = 100
               account = Bank::CheckingAccount.new(12345, start_balance)

               account.withdraw_with_check(withdrawal_amount).must_equal start_balance - withdrawal_amount

          end

          it "Allows the balance to go down to -$10" do

               start_balance = 300
               withdrawal_amount = 310
               deficit_limit = -10
               account = Bank::CheckingAccount.new(12345, start_balance)

               account.withdraw_with_check(withdrawal_amount).must_equal deficit_limit

          end

          it "Outputs a warning if the account would go below -$10" do

               start_balance = 300
               withdrawal_amount = 311
               account = Bank::CheckingAccount.new(12345, start_balance)

               proc {account.withdraw_with_check(withdrawal_amount)}.must_output /.+/

          end

          it "Doesn't modify the balance if the account would go below -$10" do

               start_balance = 300
               withdrawal_amount = 311
               account = Bank::CheckingAccount.new(12345, start_balance)

               account.withdraw_with_check(withdrawal_amount).must_equal start_balance

          end

          it "Requires a positive withdrawal amount" do

              start_balance = 300
              withdrawal_amount = -1
              account = Bank::CheckingAccount.new(12345, start_balance)

              proc {account.withdraw_with_check(withdrawal_amount)}.must_raise ArgumentError

          end

          it "Allows 3 free uses" do

             start_balance = 300
             withdrawal_amount = 1
             account = Bank::CheckingAccount.new(12345, start_balance)

               3.times do

                  account.withdraw_with_check(withdrawal_amount)

               end

               account.check_withdrawal_fee.must_equal 0


          end

          it "Applies a $2 fee after the third use" do

               start_balance = 300
               withdrawal_amount = 1
               account = Bank::CheckingAccount.new(12345, start_balance)

               4.times do

                   account.withdraw_with_check(withdrawal_amount)

               end

               account.check_withdrawal_fee.must_equal 2



          end
  end

     describe "#reset_checks" do

          it "Can be called without error" do

               start_balance = 300
               withdrawal_amount = 1
               account = Bank::CheckingAccount.new(12345, start_balance)

               4.times do

                   account.withdraw_with_check(withdrawal_amount)

               end

               account.reset_checks.must_equal 0
          end

          it "Makes the next three checks free if less than 3 checks had been used" do

             start_balance = 300
             withdrawal_amount = 1
             account = Bank::CheckingAccount.new(12345, start_balance)

             2.times do

                 account.withdraw_with_check(withdrawal_amount)

             end

             account.reset_checks

             3.times do

                 account.withdraw_with_check(withdrawal_amount)

             end

             account.check_withdrawal_fee.must_equal 0

          end

         it "Makes the next three checks free if more than 3 checks had been used" do


            start_balance = 300
            withdrawal_amount = 1
            account = Bank::CheckingAccount.new(12345, start_balance)

            5.times do

                account.withdraw_with_check(withdrawal_amount)

            end

            account.reset_checks

            3.times do

                account.withdraw_with_check(withdrawal_amount)

            end

            account.check_withdrawal_fee.must_equal 0

         end

     end
     
end
