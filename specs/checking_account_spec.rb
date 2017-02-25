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

  describe "#withdraw_using_check" do
    it "Reduces the balance" do

         start_balance = 300
         withdrawal_amount = 100
         withdrawal_fee = 0
         account = Bank::CheckingAccount.new(12345, start_balance)
         account.withdraw_using_check(withdrawal_amount)

         account.withdraw(withdrawal_amount).must_equal start_balance - (withdrawal_amount + withdrawal_fee)

    end

    xit "Returns the modified balance" do

         account.withdraw(withdrawal_amount).must_equal

    end

    xit "Allows the balance to go down to -$10" do
      # TODO: Your test code here!
    end

    xit "Outputs a warning if the account would go below -$10" do
      # TODO: Your test code here!
    end

    xit "Doesn't modify the balance if the account would go below -$10" do
      # TODO: Your test code here!
    end

    xit "Requires a positive withdrawal amount" do
      # TODO: Your test code here!
    end

    xit "Allows 3 free uses" do
      # TODO: Your test code here!
    end

    xit "Applies a $2 fee after the third use" do
      # TODO: Your test code here!
    end
  end

  xdescribe "#reset_checks" do
    it "Can be called without error" do
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if less than 3 checks had been used" do
      # TODO: Your test code here!
    end

    it "Makes the next three checks free if more than 3 checks had been used" do
      # TODO: Your test code here!
    end
  end
end
