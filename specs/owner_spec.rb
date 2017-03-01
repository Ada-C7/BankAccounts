require_relative 'spec_helper'
require_relative '../lib/account'
require_relative '../lib/owner'

describe "Owner#initialize" do
  it "Creates new owner without all parameters present" do
    id = 12345
    first_name = "Alix"
    last_name = "Hamilton"
    account = Bank::Owner.new(id: id, first_name: first_name, last_name: last_name)

    account.must_respond_to :id
    account.id.must_equal id

    account.must_respond_to :first_name
    account.first_name.must_equal first_name

    account.must_respond_to :last_name
    account.last_name.must_equal last_name
  end

  it "Raises an error when an owner is initialized without an ID." do
    proc {
      Bank::Owner.new(first_name: "Alix", last_name: "Hamilton")
    }.must_raise ArgumentError
  end

  it "New owner attribute classes match schema data types" do
    owner_info = CSV.read("support/owners.csv").first
    owner = Bank::Owner.new(
      id: owner_info[0],
      last_name: owner_info[1],
      first_name: owner_info[2],
      street_address: owner_info[3],
      city: owner_info[4],
      state: owner_info[5]
    )

    owner.id.must_be_instance_of Integer
    owner.last_name.must_be_instance_of String
    owner.first_name.must_be_instance_of String
    owner.street_address.must_be_instance_of String
    owner.city.must_be_instance_of String
    owner.state.must_be_instance_of String
  end
end

describe "Owner.all" do
  before do
    @owners = Bank::Owner.all
  end

  it "Returns a collection of Owner instances" do
    @owners.must_be_instance_of Array
    @owners.each { |owner| owner.must_be_instance_of Bank::Owner }
  end

  it "Returns the correct number of owners" do
    number_of_owners = CSV.read("support/owners.csv").count
    @owners.length.must_equal number_of_owners
  end

  it "Returns a complete array of owners from the csv file" do
    # The ID and balance of the first and last
    # accounts match what's in the CSV file
    first_owner = CSV.read("support/owners.csv").first
    @owners[0].id.must_equal first_owner[0].to_i
    @owners[0].street_address.must_equal first_owner[3]

    last_owner = CSV.read("support/owners.csv").last
    @owners[-1].id.must_equal last_owner[0].to_i
    @owners[-1].street_address.must_equal last_owner[3]
  end
end

describe "Owner.find" do
  it "Returns an owner that exists" do
    found_owner = Bank::Owner.find(16)

    found_owner.must_be_instance_of Bank::Owner
    found_owner.street_address.must_equal "9 Portage Court"
  end

  it "Can find the first owner from the CSV" do
    first_owner = CSV.read("support/owners.csv").first
    first_owner_id = first_owner[0].to_i
    first_owner_street_address = first_owner[3]
    found_owner = Bank::Owner.find(first_owner_id)

    found_owner.id.must_equal first_owner_id
    found_owner.street_address.must_equal first_owner_street_address
  end

  it "Can find the last owner from the CSV" do
    last_owner = CSV.read("support/owners.csv").last
    last_owner_id = last_owner[0].to_i
    last_owner_street_address = last_owner[3]
    found_owner = Bank::Owner.find(last_owner_id)

    found_owner.id.must_equal last_owner_id
    found_owner.street_address.must_equal last_owner_street_address
  end

  it "Raises an error for an owner that doesn't exist" do
    proc {
      Bank::Owner.find("HAMBURGLER")
    }.must_raise ArgumentError
  end
end
