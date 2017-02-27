require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'
require_relative '../lib/account'

describe "Wave 1- optionals" do

  describe "Owner#initialize" do
    it "Takes an owner hash" do
      janice_hash={id:12345, last_name:'Lichtman', first_name:'Janice',  street_address:'16-28 Radburn Rd', city:'Fair Lawn', state:'NJ'}
      janice = Bank::Owner.new(janice_hash)

      janice.must_respond_to :id
      janice.id.must_equal janice_hash[:id]

      janice.must_respond_to :last_name
      janice.last_name.must_equal janice_hash[:last_name]

      janice.must_respond_to :first_name
      janice.first_name.must_equal janice_hash[:first_name]

      janice.must_respond_to :street_address
      janice.street_address.must_equal janice_hash[:street_address]

      janice.must_respond_to :city
      janice.city.must_equal janice_hash[:city]

      janice.must_respond_to :state
      janice.state.must_equal janice_hash[:state]
    end
  end

  describe "Adding owner to account" do
    it "associates an owner, and the owner's details, with an account" do
      janice = Bank::Owner.new(id:12345, first_name:"Janice")
      janices_account=Bank::Account.new('jans_acct_id',100)
      janices_account.owner = janice

      janices_account.owner.first_name.must_equal "Janice"
    end

    it "has an owner of the Owner class" do
      janice = Bank::Owner.new(id:12345, first_name:"Janice")
      janices_account=Bank::Account.new('jans_acct_id',100)
      janices_account.owner = janice

      janices_account.owner.must_be_instance_of Bank::Owner
    end
  end

end
