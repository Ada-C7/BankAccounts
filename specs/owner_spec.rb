require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
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
end
