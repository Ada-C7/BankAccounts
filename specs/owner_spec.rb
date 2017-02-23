require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'
require 'csv'

# Owner class inside Bank Module:
describe "Owner#initialize" do
  it "Can be instantiated" do
    owner = Bank::Owner.new(1111, "Kuleniuk")
    owner.must_be_instance_of Bank::Owner , "Made a owner, but it is not a Owner class"
  end
  it "Takes name and id" do
    last_name = "Natalia"
    id = 123
    owner = Bank::Owner.new(id, last_name)
    owner.must_respond_to :last_name
    owner.last_name.must_equal last_name
    owner.must_respond_to :id
    owner.id.must_equal id
  end
  it "Input must be string and integer:" do
    owner = Bank::Owner.new(1234,"Kuleniuk")
    owner.last_name.must_be_kind_of String
    owner.id.must_be_kind_of Integer
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
  it "Returns an owner that exists" do
    result = Bank::Owner.find(23)
    result.must_be_kind_of Bank::Owner
  end

  it "Can find the first owner from the CSV" do
    csv = CSV.read("../support/owners.csv", 'r')
    result = Bank::Owner.find(csv[0][0].to_i)
    result.id.must_be :==, Bank::Owner.all[0].id
    result.last_name.must_be :==, Bank::Owner.all[0].last_name
  end

  it "Can find the last owner from the CSV" do
    csv = CSV.read("../support/owners.csv", 'r')
    result = Bank::Owner.find(csv[11][0].to_i)
    result.id.must_be :==, Bank::Owner.all[11].id
    result.last_name.must_be :==, Bank::Owner.all[11].last_name
  end

  it "Raises an error for an owner that doesn't exist" do
    proc {
      Bank::Owner.find(100000)
    }.must_raise ArgumentError
  end
end
