require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

# TODO: uncomment the next line once you start wave 3 and add lib/checking_account.rb
require_relative '../lib/checking_account'

# Because a CheckingAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "CheckingAccount" do
  describe "#initialize" do
    # Check that a CheckingAccount is in fact a kind of account
    it "Is a kind of Account" do
      id = 12345
      balance = 100.0
      account = Bank::CheckingAccount.new(id, balance)
      account.must_be_kind_of Bank::Account

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance
    end
  end
end

  describe "#withdraw" do
    it "Applies a $1 fee each time" do
      # TODO: Your test code here!
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - (withdrawal_amount+1)
      account.balance.must_equal expected_balance
    end

    it "Doesn't modify the balance if the fee would put it negative" do
      # TODO: Your test code here!
      start_balance = 100.0
      withdrawal_amount = 100.0
      account = Bank::CheckingAccount.new(12345, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end
  end

#   describe "#withdraw_using_check" do
#     it "Reduces the balance" do
#       # TODO: Your test code here!
#     end
#
#     it "Returns the modified balance" do
#       # TODO: Your test code here!
#     end
#
#     it "Allows the balance to go down to -$10" do
#       # TODO: Your test code here!
#     end
#
#     it "Outputs a warning if the account would go below -$10" do
#       # TODO: Your test code here!
#     end
#
#     it "Doesn't modify the balance if the account would go below -$10" do
#       # TODO: Your test code here!
#     end
#
#     it "Requires a positive withdrawal amount" do
#       # TODO: Your test code here!
#     end
#
#     it "Allows 3 free uses" do
#       # TODO: Your test code here!
#     end
#
#     it "Applies a $2 fee after the third use" do
#       # TODO: Your test code here!
#     end
#   end
#
#   describe "#reset_checks" do
#     it "Can be called without error" do
#       # TODO: Your test code here!
#     end
#
#     it "Makes the next three checks free if less than 3 checks had been used" do
#       # TODO: Your test code here!
#     end
#
#     it "Makes the next three checks free if more than 3 checks had been used" do
#       # TODO: Your test code here!
#     end
#   end
# end
