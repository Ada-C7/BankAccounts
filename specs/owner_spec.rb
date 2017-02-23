require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

describe "Optional - Owner Class" do

  describe "Owner#initialize" do

    it "Takes in hash and stores the owner info." do
      # skip
      person_info = {
                      id: 10,
                      last_name: "Cobb",
                      first_name: "Cynthia",
                      street: "123 Street",
                      city: "Seattle",
                      state: "WA"
                    }

      account_owner = Bank::Owner.new(person_info)
      account_owner.must_be_kind_of Bank::Owner

      account_owner.must_respond_to :id
      account_owner.id.must_equal person_info[:id]

      account_owner.must_respond_to :last_name
      account_owner.last_name.must_equal person_info[:last_name]

      account_owner.must_respond_to :first_name
      account_owner.first_name.must_equal person_info[:first_name]

      account_owner.must_respond_to :street_address
      account_owner.street_address.must_equal person_info[:street]

      account_owner.must_respond_to :city
      account_owner.city.must_equal person_info[:city]

      account_owner.must_respond_to :state
      account_owner.state.must_equal person_info[:state]
    end
  end

  describe "Owner#All" do

    it "requires 1 argument" do
      proc {
        Bank::Owner.all()
      }.must_raise ArgumentError
    end

    it "returns array that has length greater than 0 " do
      # must be an array
      Bank::Owner.all('../support/owners.csv').must_be_instance_of Array
      Bank::Owner.all('../support/owners.csv').length.must_be :>, 0
    end

    it "returns an array of length 12 when given file with 12 users" do
      Bank::Owner.all('../support/owners.csv').length.must_equal 12
    end

    it "returns an array full of owner objects" do
      # this test is not being run untill there is an array that is greater than 0
      # was not running if the array is empty - not failing
      Bank::Owner.all('../support/owners.csv').each do |account|
        account.must_be_instance_of Bank::Owner
      end
    end

  end

  describe "Owner#Find" do

    it "requires 1 argument" do
      proc {
        Bank::Owner.find()
      }.must_raise ArgumentError
    end

    it "returns an owner object" do
      Bank::Owner.all('../support/owners.csv')
      Bank::Owner.find(24).must_be_instance_of Bank::Owner
    end

    it "find the first owner" do
      Bank::Owner.all('../support/owners.csv')
      Bank::Owner.find(14).last_name.must_equal "Morales"
    end

    it "finds the last owner" do
      Bank::Owner.all('../support/owners.csv')
      Bank::Owner.find(25).last_name.must_equal "Clark"
    end
  end

end



# describe "Account.all" do
#   # skip
#   it "Returns an array of all accounts" do
#     # Account.all returns an array
#     Bank::Account.all.must_be_instance_of Array
#
#     # Everything in the array is an Account
#     Bank::Account.all.each do |account_object|
#       account_object.must_be_instance_of Bank::Account
#     end
#
#     # The number of accounts is correct
#     Bank::Account.all.length.must_equal 12
#
#     # each item responds to the id and balance methods
#     Bank::Account.all.each { |acount_object| acount_object.must_respond_to :id }
#     Bank::Account.all.each { |acount_object| acount_object.must_respond_to :balance }
#   end
# end
