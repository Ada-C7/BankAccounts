require 'csv'


# CSV.read("./support/accounts.csv").each do |line|
# #print line
# print line[0]
# end

csv = []
CSV.read("./support/accounts.csv").each do |data|
print data
#csv << data[0]
end

  # print csv
