require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'

describe "Owner#initialize" do

  it "Takes name, address, and email in a hash" do
    user_info =
      {:name => "ann",
      :address => "1234 happy lane",
      :email => "gofarann@gmail.com"}

    owner = Bank::Owner.new(user_info)

    owner.name.must_equal user_info[:name]
    owner.address.must_equal "1234 happy lane"
    owner.email.must_equal "gofarann@gmail.com"
  end

end
