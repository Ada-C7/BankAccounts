require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

describe "Owner#initialize" do
  it "Takes a last name and a first name" do
    last_name = "Persnickety"
    first_name = "Eloise"
    owner = Bank::Owner.new(last_name, first_name)

    owner.must_respond_to :last_name
    owner.last_name.must_equal last_name

    owner.must_respond_to :first_name
    owner.first_name.must_equal first_name
  end

  # it "Takes an address" do
  #   address = {
  #     address1: "787 Somewhere St.",
  #     address2: "Unit X",
  #     city: "Albuquerque",
  #     st: "NM",
  #     zip: 87101
  #   }
  # end

end
