require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require 'csv'
require_relative '../lib/account'
require_relative '../lib/owner'

describe "Wave 1 Optional" do

  before do
    brenna_hash = {id: 0522, last_name: "Darroch", first_name: "Brenna", st_address: "3426 Cotton Top Ct", city: "Fairfax", state: "VA"}
    @brenna = Bank::Owner.new(brenna_hash)
    @account = Bank::Account.new(1234, 333, "May 22, 2011", @brenna)
    @owners = Bank::Owner.all
  end

  describe "Owner#initialize" do
    it "Takes a hash with data on ID, first and last name, street address, city, and state." do
      @account.owner.id.must_equal 0522
      @account.owner.last_name.must_equal "Darroch"
      @account.owner.first_name.must_equal "Brenna"
      @account.owner.st_address.must_equal "3426 Cotton Top Ct"
      @account.owner.city.must_equal "Fairfax"
      @account.owner.state.must_equal "VA"
    end
  end

  describe "Owner.all" do

      it "Returns an array of all owners" do
        @owners.must_be_kind_of Array
      end

      it "Everything in the array is an Owner" do
        @owners.each do |inst|
          inst.must_be_instance_of Bank::Owner
        end
      end

      it "The number of owners is correct" do
        @owners.length.must_equal 12
      end

      it "The elements match what's in the file" do
        index = 0
        CSV.read("support/owners.csv") do |line|
          @owners[index].id.must_equal line[0].to_i
          @owners[index].last_name.must_equal line[1]
          @owners[index].last_name.must_equal line[2]
          @owners[index].st_address.must_equal line[3]
          @owners[index].city.must_equal line[4]
          @owners[index].state.must_equal line[5]
          index += 1
        end
      end
    end

    describe "Owner.find" do

      it "Returns an account that exists" do
        id_check = @owners[4].id
        owner = Bank::Owner.find(id_check)
        expect(owner.id).must_equal id_check
      end

      it "Can find the first account from the CSV" do
        id_check = @owners[0].id
        owner = Bank::Owner.find(id_check)
        expect(owner.id).must_equal id_check
      end

      it "Can find the last account from the CSV" do
        id_check = @owners[-1].id
        owner = Bank::Owner.find(id_check)
        expect(owner.id).must_equal id_check
      end

      it "Raises an error for an account that doesn't exist" do
        proc {
          Bank::Owner.find(12345)
          }.must_raise ArgumentError
      end

    end


end
