require 'csv'
require 'ap'
module Bank
  class Account

    attr_reader :id, :balance, :open_date
    def initialize(id, balance, open_date ="")
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      @open_date = open_date

    end

    @@account_all = []

    @@csv = []
    CSV.read("./support/accounts.csv").each do |account|
      @@csv << {id: account[0].to_i, balance: account[1].to_i, open_date: account[2]}
    end


    def self.csv
      return @@csv
    end

    @@csv.each do |account|
      @@account_all << self.new(account[:id].to_i, account[:balance].to_i, account[:open_date])
    end

    def self.all
      return @@account_all
    end


    def self.find(entered_id)
      @@account_all.each do |account|
        if account.id == entered_id
          return account
        end
      end
        raise ArgumentError.new "Entered ID doesn't exist"
    end


    def withdraw(amount)
      if amount < 0
        raise ArgumentError.new "Negative amount entered for withdrawal"
      else
        new_balance = @balance - amount
        if new_balance < 0
          puts "Withdrawal amount greater than the current balance"
          @balance = @balance
        else
        @balance = new_balance
        end
      end
    end

    def deposit(amount)
      if amount < 0
        raise ArgumentError.new "Minus amount deposited"
      else
        new_balance = @balance + amount
        @balance = new_balance
      end

    end

  end

#     class Owner
#       attr_reader :last_name, :first_name, :address
#       def initialize(last_name, first_name, address)
#         @last_name = last_name
#         @first_name = first_name
#         @address = address
#       end
#
#       @@owner = []
#       @@csv = []
#       # CSV.read("../support/accounts.csv").each do |account|
#       #   @@csv << {id: account[0].to_i, balance: account[1].to_i, open_date: account[2]}
#       # end
#       CSV.read("../support/owners.csv").each do |owner|
#         @@owner << {last_name: owner[1], first_name: owner[2], address: owner[3]}
#       end
# # ap @@owner[0].last_name
# # puts Bank::Account.csv
# # puts @@owner
#
#
#       def self.merge_info
#         n = 0
#         @@owner.length.times do |n|
#           Bank::Account.csv[n].merge!(@@owner[n])
#           n +=1
#         end
#       end
#
#
#
#
#     end




end

# a = Bank::Account.new(12334, 5000)
# puts a.id
# Bank::Owner.merge_info
# ap Bank::Account.csv
