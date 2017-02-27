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

describe "Wave 2- optionals" do

  describe "Owner.all" do
    it "Returns an array" do
      Bank::Owner.reset_all_owners_for_test
      Bank::Owner.read_csv
      expect(Bank::Owner.all).must_be_instance_of Array, "Not an array."
    end

    it "Returns an array consisting only of owners" do
      Bank::Owner.reset_all_owners_for_test
      Bank::Owner.read_csv
      Bank::Owner.all.each do |owner|
        owner.must_be_instance_of Bank::Owner, "Not an instance of Account class."
      end
    end

    it "Returns an array with the correct number of accounts" do
      Bank::Owner.reset_all_owners_for_test
      Bank::Owner.read_csv
      expect(Bank::Owner.all.length).must_equal 12, "Wrong number of accounts"
    end

    it "gives correct values for the ID and state of the first and last
    accounts match what's in the CSV file" do
    Bank::Owner.reset_all_owners_for_test
    Bank::Owner.read_csv
    expect(Bank::Owner.all.first.id).must_equal 14, "ID of first owner is incorrect."
    Bank::Owner.reset_all_owners_for_test
    Bank::Owner.read_csv
    expect(Bank::Owner.all.first.state).must_equal "Hawaii", "State of first owner is incorrect."
    Bank::Owner.reset_all_owners_for_test
    Bank::Owner.read_csv
    expect(Bank::Owner.all.last.id).must_equal 25, "ID of second owner is incorrect."
    Bank::Owner.reset_all_owners_for_test
    Bank::Owner.read_csv
    expect(Bank::Owner.all.last.state).must_equal "New York", "ID of second owner is incorrect."
  end
end

describe "Owner.find" do
  it "Returns an Owner that exists" do
    Bank::Owner.reset_all_owners_for_test
    Bank::Owner.read_csv
    expect(Bank::Owner.find(20)).must_be_instance_of Bank::Owner, "Does not return account"
  end

  it "Can find the first account from the CSV" do
    Bank::Owner.reset_all_owners_for_test
    Bank::Owner.read_csv
    expect(Bank::Owner.find(14)).must_equal Bank::Owner.all.first, "Cannot find first account"
  end

  it "Can find the last account from the CSV" do
    Bank::Owner.reset_all_owners_for_test
    Bank::Owner.read_csv
    expect(Bank::Owner.find(25)).must_equal Bank::Owner.all.last, "Cannot find last account"
  end

  it "Raises an error for an account that doesn't exist" do
    Bank::Owner.reset_all_owners_for_test
    Bank::Owner.read_csv
    proc {
      Bank::Owner.find(9999999)
    }.must_raise ArgumentError
  end
end
end
