require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

# Owner class inside Bank Module:
describe "Owner#initialize" do
  it "Can be instantiated" do
    owner = Bank::Owner.new("David")
    owner.must_be_instance_of Bank::Owner , "Made a owner, but it is not a Owner class"
  end
  it "Takes name" do
    name = "Natalia"
    owner = Bank::Owner.new(name)

    owner.must_respond_to :name
    owner.name.must_equal name

  end
  it "Input must be string:" do
    owner = Bank::Owner.new("Natalia")
    owner.name.must_be_kind_of String
  end
end

describe "Owner#all" do
  it "Owner.all returns an array" do
    all_owners = Bank::Owner.all
    all_owners.must_be_kind_of Array
  end
  it "Everything in the array is an Owner" do
    all_owners = Bank::Owner.all
    all_owners.each do |owner|
      owner.must_be_kind_of Bank::Owner
    end
  end
  it " The number of owners is correct" do
    all_owners = Bank::Owner.all
    all_owners.length.must_be :==, 12
  end


end

describe "Owner#find(id)" do
end
