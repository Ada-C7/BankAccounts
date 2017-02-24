require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'
require_relative '../lib/account'

describe "Wave 1- optionals" do

  describe "Owner#initialize" do
    it "Takes an owner hash" do
      janice_hash={name:"Janice Lichtman", address:"512A N 46th St, Seattle, WA", birthday:"May 16, 1974", pets_name: "Marshmallo"}
      janice = Bank::Owner.new(janice_hash)

      janice.must_respond_to :name
      janice.name.must_equal janice_hash[:name]

      janice.must_respond_to :address
      janice.address.must_equal janice_hash[:address]

      janice.must_respond_to :birthday
      janice.birthday.must_equal janice_hash[:birthday]

      janice.must_respond_to :pets_name
      janice.pets_name.must_equal janice_hash[:pets_name]
    end
  end

  describe "Adding owner to account" do
    it "associates an owner, and the owner's details, with an account" do
      janice = Bank::Owner.new(name:"Janice")
      janices_account=Bank::Account.new('jans_acct_id',100)
      janices_account.owner = janice

      janices_account.owner.name.must_equal "Janice"
    end

    it "has an owner of the Owner class" do
      janice = Bank::Owner.new(name:"Janice")
      janices_account=Bank::Account.new('jans_acct_id',100)
      janices_account.owner = janice

      janices_account.owner.must_be_instance_of Bank::Owner
    end
  end

end
