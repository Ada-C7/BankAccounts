require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

Minitest::Reporters.use!

describe "Owner#initialize" do
  it "Takes a name, address, and email" do
    owner_hash = {
      name: "Ada",
      address: "123 Fake Street",
      email: "ada@example.com"
    }
    owner = Bank::Owner.new(owner_hash)

    owner.must_respond_to :name
    owner.name.must_equal owner_hash[:name]

    owner.must_respond_to :address
    owner.address.must_equal owner_hash[:address]

    owner.must_respond_to :email
    owner.email.must_equal owner_hash[:email]
  end

  it "Raises ArgumentError when created without a name, address, or email" do
    owner_hash1 = { address: "123 Fake Street", email: "ada@example.com" }
    owner_hash2 = { name: "Ada", email: "ada@example.com" }
    owner_hash3 = { name: "Ada", address: "123 Fake Street" }
    owner_hash4 = { name: "Ada" }
    owner_hash5 = { address: "123 Fake Street" }
    owner_hash6 = { email: "ada@example.com" }
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
