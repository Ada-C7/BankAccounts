require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

describe "Owner#initialize" do

  before do
    @owner_hash = {
      :in_first_name => "Grace",
      :in_last_name => "Hopper",
      :in_address => "456 Anytown, USA",
      :in_phone => "206-440-0725"
    }

    @owner = Bank::Owner.new(@owner_hash)
  end

  it "Takes a first and last name" do



    @owner.must_respond_to :first_name #this is the instance variable in the class
    @owner.first_name.must_equal @owner_hash[:in_first_name] #this is the key-value pair in the passed Hash

    @owner.must_respond_to :last_name #this is the instance variable in the class
    @owner.last_name.must_equal @owner_hash[:in_last_name] #this is the key-value pair in the passed Hash

  end

  it "Takes an address" do
    @owner.must_respond_to :address
    @owner.address.must_equal @owner_hash[:in_address]
  end

  it "Takes a phone number" do
    @owner.must_respond_to :phone_number
    @owner.phone_number.must_equal @owner_hash[:in_phone]
  end


end
