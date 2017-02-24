require 'money'


# print Time.parse("1999-03-27 11:30:09 -0800")

my_money = Money.new('100', 'USD')
my_money.format

# array = []
# CSV.foreach("../support/accounts.csv") do |row|
#    array << row
# end
# print array
