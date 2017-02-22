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
end
