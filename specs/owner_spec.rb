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

end
