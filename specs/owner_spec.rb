# require 'minitest/autorun'
# require 'minitest/reporters'
# require 'minitest/skip_dsl'
# require_relative '../lib/account'
#
# describe "Optionals" do
#     describe "0wner#initialize" do
#       it "takes the name of Account owner and their address" do
#         name = "Anna Elisabeth"
#         address = "house on the left, pumpkin lane, seattle, WA"
#
#         owner = Bank::Owner.new(name, address)
#
#         owner.must_respond_to :name
#         owner.name.must_equal name
# 
#         owner.must_respond_to :address
#         owner.address.must_equal address
#       end
#
#       # it "throws an error if intialized without name + address" do
#       #   name = "Anna Elisabeth"
#       #   owner = Bank::Owner.new(name)
#       # end
#       # end
#     end
#
# end
