require_relative 'account'
require 'csv'
require 'date'
module Bank
  class Owner
    attr_reader :name, :address, :phone
    def initialize (name, phone="1234456", last_name="Fakelastname" , first_name="Fakefirstname", address="123 Main st", city="Bellevue", state="WA")
      @name = name
      #@address = address
      #@phone = phone
    end

    def self.all
      csv = CSV.read("../support/owners.csv", 'r') # object of class CSV
      all_owners = []
      n = 0 # current line of csv file
      csv.length.times do |n|
        id = csv[n][0].to_i
        last_name = csv[n][1]
        first_name = csv[n][2]
        address = csv[n][3]
        city = csv[n][4]
        state = csv[n][5]
        all_owners << Owner.new(id, last_name, first_name, address, city, state)
        n += 1
      end
      return all_owners
    end


  end
end

 owner = Bank::Owner.new("Natalia")
 puts Bank::Owner.all
# puts owner.address
