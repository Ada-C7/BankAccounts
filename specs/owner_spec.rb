require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

# Owner class inside Bank Module:
describe "Owner#initialize" do
  it "Can be instantiated" do
    owner = Bank::Owner.new("David", "123 Street", "32329449")
    owner.must_be_instance_of Bank::Owner , "Made a owner, but it is not a Owner class"
  end
  it "Takes name, address and phone" do
    name = "Natalia"
    address = "234 Main NE St"
    phone = "42354565"
    owner = Bank::Owner.new(name, address, phone)

    owner.must_respond_to :name
    owner.name.must_equal name

    owner.must_respond_to :address
    owner.address.must_equal address

    owner.must_respond_to :phone
    owner.phone.must_equal phone
  end
  it "Input must be string:" do
    owner = Bank::Owner.new("Natalia", "234 Street", "43434343434")
    owner.name.must_be_kind_of String
    owner.address.must_be_kind_of String
    owner.phone.must_be_kind_of String
  end
end
