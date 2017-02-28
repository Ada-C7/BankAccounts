

require 'csv'

def self.all
  accounts_master = CSV.read("../support/accounts.csv")
  accounts_master.each_with_object(self).to_a
end
self.all.count



# def self.find(id)
#   #returns an instance of Account where the value of the id field in the CSV matches the passed parameter.
# end
#

















# each do |line|
#   (1...line.length).each do |i|
#     @words[ line[0] ] << line[i]
