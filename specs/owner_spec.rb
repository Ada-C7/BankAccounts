require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/owner'
require 'csv'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

xdescribe "Owner#initialize" do



end

describe "Owner.all"do
  before do
    @owners = Bank::Owner.all
  end

  it "returns an array"do
    @owners.must_be_instance_of Array
  end

  it "Every in Array is an Owner"do
    @owners.each do |owner|
      owner.must_be_instance_of Bank::Owner
    end
  end

  it "Has 12 Owners" do
    check_array = CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/owners.csv")
    @owners.length.must_equal check_array.length
  end

end


describe "Owner.find(id)" do
  before do
    @owners = Bank::Owner.all
  end

  it "Returns an owner that exists" do
    find_owner = Bank::Owner.find(16)
    find_owner.must_be_instance_of Bank::Owner
  end

  it "Can find the first account from the CSV" do
    test_array = CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/owners.csv")
    id_check = test_array[0][0].to_i
    find_owner = Bank::Owner.find(14)
    find_owner.id.must_equal id_check
  end

  it "Can find the last account from the CSV" do
    test_array = CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/owners.csv")
    id_check = test_array[-1][0].to_i
    find_owner = Bank::Owner.find(25)
    find_owner.id.must_equal id_check
  end

  it "Raises an Error for an account hat doesn't exist" do
    proc {
      Bank::Owner.find(77)
    }.must_output /.+/
  end
end
