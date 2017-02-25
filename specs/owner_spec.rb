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

describe "Owner class methods" do
  before do
    @owner_array = Bank::Owner.all
    @csv_info = CSV.read('support/owners.csv')
  end

  describe "Owner#all" do
    it "Owner#all returna an array" do
      @owner_array.must_be_instance_of Array
    end

    it "Everything in the array is an Owner" do
      @owner_array.each do |owner|
        owner.must_be_instance_of Bank::Owner
      end
    end

    it "The number of owners is correct" do
      @owner_array.length.must_equal @csv_info.count
    end

    it "The information for the first & last owners is correct" do
      @owner_array[0].id.must_equal @csv_info[0][0].to_i
      @owner_array[0].last_name.must_equal @csv_info[0][1]
      @owner_array[0].first_name.must_equal @csv_info[0][2]
      @owner_array[0].address.must_equal @csv_info[0][3]
      @owner_array[0].city.must_equal @csv_info[0][4]
      @owner_array[0].state.must_equal @csv_info[0][5]

      @owner_array[-1].id.must_equal @csv_info[-1][0].to_i
      @owner_array[-1].last_name.must_equal @csv_info[-1][1]
      @owner_array[-1].first_name.must_equal @csv_info[-1][2]
      @owner_array[-1].address.must_equal @csv_info[-1][3]
      @owner_array[-1].city.must_equal @csv_info[-1][4]
      @owner_array[-1].state.must_equal @csv_info[-1][5]
    end
  end

  describe "Owner#find" do
    it "Returns an owner that exists" do
      Bank::Owner.find(20).must_be_instance_of Bank::Owner
      Bank::Owner.find(20).first_name.must_equal "Helen"
    end

    it "Can find the first owner from the CSV" do
      Bank::Owner.find(@csv_info[0][0].to_i).must_be_instance_of Bank::Owner
      Bank::Owner.find(@csv_info[0][0].to_i).last_name.must_equal @csv_info[0][1]
    end

    it "Can find the last owner from the CSV" do
      Bank::Owner.find(@csv_info[-1][0].to_i).must_be_instance_of Bank::Owner
      Bank::Owner.find(@csv_info[-1][0].to_i).address.must_equal @csv_info[-1][3]
    end

    it "Raises an error for an owner that doesn't exist" do
      proc { Bank::Owner.find(9873) }.must_raise ArgumentError
    end
  end
end
