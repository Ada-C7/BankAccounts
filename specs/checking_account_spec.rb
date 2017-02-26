# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
#
# describe "CheckingAccount" do
#   describe "#initialize" do
#     # Check that a CheckingAccount is in fact a kind of account
#     it "Is a kind of Account" do
#       account = Bank::CheckingAccount.new(12345, 100.0)
#       account.must_be_kind_of Bank::Account
#     end
#   end
#
#   describe "#withdraw" do
#     it "Applies a $1 fee each time" do
#       # TODO: Your test code here!
#     end
#
#     it "Doesn't modify the balance if the fee would put it negative" do
#       # TODO: Your test code here!
#     end
#   end
#
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
