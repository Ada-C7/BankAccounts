require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/savings_account'

Minitest::Reporters.use!

# TODO: uncomment the next line once you start wave 3 and add lib/savings_account.rb
# require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do

     describe "#initialize" do

          it "Is a kind of Account" do

                account = Bank::SavingsAccount.new(12345, 100.0)
                account.must_be_kind_of Bank::Account

         end

          it "Requires an initial balance of at least $10" do

              proc {
                Bank::SavingsAccount.new(1337, -100.0)
              }.must_raise ArgumentError

              proc {
                Bank::SavingsAccount.new(1337, -0.0)
              }.must_raise ArgumentError

              proc {
                Bank::SavingsAccount.new(1337, 9.0)
              }.must_raise ArgumentError

          end
     end

     describe "#withdraw" do

         # it "Applies a $2 fee each time" do
         #   # TODO: Your test code here!
         # end

         it "Outputs a warning if the balance would go below $10" do

              start_balance = 50.0
              withdrawal_amount = 48.0
              account = Bank::SavingsAccount.new(1337, start_balance)

              proc {
                account.withdraw(withdrawal_amount)
              }.must_output /.+/

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

  #describe "#add_interest" do
    it "Returns the interest calculated" do
      # TODO: Your test code here!
    end

    it "Updates the balance with calculated interest" do
      # TODO: Your test code here!
    end

    it "Requires a positive rate" do
      # TODO: Your test code here!
    end

end
