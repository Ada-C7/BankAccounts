require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

describe "Optional - Owner Class" do

  describe "Owner#initialize" do
    it "Takes in hash and stores the owner info." do
      # skip
      person_info = {
                    last_name: "Cobb",
                    first_name: "Cynthia",
                    phone_number: "234-456-7890",
                    street: "123 Street",
                    city: "seattle",
                    zipcode: "98011",
                    state: "WA"
                    }

      account_owner = Bank::Owner.new(person_info)

      account_owner.must_respond_to :last_name
      account_owner.last_name.must_equal person_info[:last_name]

      account_owner.must_respond_to :first_name
      account_owner.first_name.must_equal person_info[:first_name]

      account_owner.must_respond_to :phone_number
      # proc { account_owner.phone_number } .must_output /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
      account_owner.phone_number.must_equal person_info[:phone_number]
    end
  end
end
