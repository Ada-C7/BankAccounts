require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

Minitest::Reporters.use!

describe "Owner#initialize" do
  it "Takes all required info from a hash" do
    owner_hash = {
      id: 4,
      last_name: "Lovelace",
      first_name: "Ada",
      address: "123 Fake Street",
      city: "Fake City",
      state: "Fake State"
    }
    owner = Bank::Owner.new(owner_hash)

    owner.must_respond_to :id
    owner.id.must_equal owner_hash[:id]

    owner.must_respond_to :last_name
    owner.last_name.must_equal owner_hash[:last_name]

    owner.must_respond_to :first_name
    owner.first_name.must_equal owner_hash[:first_name]

    owner.must_respond_to :address
    owner.address.must_equal owner_hash[:address]

    owner.must_respond_to :city
    owner.city.must_equal owner_hash[:city]

    owner.must_respond_to :state
    owner.state.must_equal owner_hash[:state]
  end

  it "Raises ArgumentError when created without required fields" do
    owner_hash1 = { last_name: "Lovelace", first_name: "Ada", address: "123 Fake Street", city: "Fake City", state: "Fake State" }
    owner_hash2 = { id: 4, first_name: "Ada", address: "123 Fake Street", city: "Fake City", state: "Fake State" }
    owner_hash3 = { id: 4, last_name: "Lovelace", address: "123 Fake Street", city: "Fake City", state: "Fake State" }
    owner_hash4 = { id: 4, last_name: "Lovelace", first_name: "Ada", city: "Fake City", state: "Fake State" }
    owner_hash5 = { id: 4, last_name: "Lovelace", first_name: "Ada", address: "123 Fake Street", state: "Fake State" }
    owner_hash6 = { id: 4, last_name: "Lovelace", first_name: "Ada", address: "123 Fake Street", city: "Fake City" }
    owner_hash7 = {}

    proc { Bank::Owner.new(owner_hash1) }.must_raise ArgumentError
    proc { Bank::Owner.new(owner_hash2) }.must_raise ArgumentError
    proc { Bank::Owner.new(owner_hash3) }.must_raise ArgumentError
    proc { Bank::Owner.new(owner_hash4) }.must_raise ArgumentError
    proc { Bank::Owner.new(owner_hash5) }.must_raise ArgumentError
    proc { Bank::Owner.new(owner_hash6) }.must_raise ArgumentError
    proc { Bank::Owner.new(owner_hash7) }.must_raise ArgumentError

  end
end
