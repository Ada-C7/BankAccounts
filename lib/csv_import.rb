require 'csv'
# require_relative 'account_wave_2'

def import_all
  my_file = CSV.open("../support/accounts.csv")
  all_accounts = []
  my_file.each do |line|
    account = [line[0], line[1].to_f, line[2]]
    all_accounts << account
  end
  # puts all_accounts
  return all_accounts
end


def find(search_for_id)
  all_accounts = import_all
  answer = nil
  all_accounts.each do |account|
    answer = account if account[0].to_i == search_for_id.to_i
  end
  return answer
end

answer = find(15151)
puts "answer is #{answer}"
puts answer.class
# import_all
