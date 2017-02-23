#require_relative 'account'
require 'csv'
require 'date'
module Bank
  class Owner
    attr_reader  :id, :last_name, :first_name, :address, :city, :state
    def initialize (id,last_name, first_name = "Fakefirstname", address = "123 Main st", city = "Bellevue", state = "WA")
      @id = id
      @last_name = last_name
      @first_name = first_name
      @address = address
      @city = city
      @state = state
    end

  # Returns array of all Owners
    def self.all
      csv = CSV.read("../support/owners.csv", 'r') # object of class CSV
      all_owners = []
      n = 0 # current line of csv file
      csv.length.times do
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

    def self.find(id)
      result = Owner.all.select {|owner| owner.id == id}
      # select method returns Array, which in our case
      # store only one element
      if result[0].nil?
        raise ArgumentError.new("Cannot find this ID in owners")
      else
        return result[0]
      end
    end
  end # end of class Owner
end # end of module Bank
