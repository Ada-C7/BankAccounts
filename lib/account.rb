require 'csv'

module Bank
    class Account
        attr_accessor :id, :balance, :account_info

        @@all_accounts = {}
        @@valid_ids = []

        def initialize(id, balance)
            raise ArgumentError, 'Cannot deposit negative number' if balance.to_f < 0
            @id = id
            @balance = balance

            @account_info = CSV.open('support/accounts.csv')

            @account_info.each do |line|
                @@all_accounts[line.first] = line.drop(1)
                @@valid_ids << line[0]
                next unless line.first == @id
                @balance = line[1].to_i
                @opendate = DateTime.parse(line[2].to_s)
            end
        end

        def self.all
            @account_info = CSV.open('support/accounts.csv')
            @accounts_array = []
            @account_info.each do |line|
                @account_instance = Bank::Account.new(line[0], line[1])
                @accounts_array << @account_instance
            end
            @accounts_array
        end

        def self.find(_id)
            @account_info = CSV.open('support/accounts.csv')
            @found_account = []

            @account_info.each do |line|
                @@valid_ids << line[0]
                next unless line.first == _id
                @found_account = line
            end

            # print @@valid_ids
            # puts @found_account

            raise ArgumentError, 'Please enter valid ID' unless @@valid_ids.include?(_id)

            @found_account
        end

        def withdraw(amt)
            raise ArgumentError, 'Cannot withdraw negative number' if amt < 0
            if @balance - amt < 0
                puts 'You cannot withdraw more than your account balance'
            else
                @balance -= amt
            end
            @balance
        end

        def deposit(amt)
            raise ArgumentError, 'Cannot deposit negative number' if amt < 0
            @balance += amt
            @balance
        end
    end
end

# Cust1 = Bank::Account.new('1212', '1235667')
# Cust2 = Bank::Account.new('1213', '66367')
# Cust3 = Bank::Account.new('1214', '9876890')
# Cust4 = Bank::Account.new('1215', '919191')
#
# print Cust2.balance
#
# puts Bank::Account.all
# puts Bank::Account.find('1213')
# puts Bank::Account.find('test')
# puts Bank::Account.find('1213')
