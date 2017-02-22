require_relative 'owner'
require 'csv'
require 'date'

module Bank
  class Account
    attr_reader :id, :balance, :owner, :date_created

    def initialize(id, balance, date_opened="1991-01-01 11:01:01 -0800")
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
    end

# Returns array of all instances of class Account
    def self.all
      csv = CSV.read("../support/accounts.csv", 'r') # object of class CSV
      all_accounts = []
      n = 0 # current line of csv file
      csv.length.times do |n|
        id = csv[n][0].to_i
        balance = csv[n][1].to_i
        date_created = DateTime.parse(csv[n][2])
        all_accounts << Account.new(id, balance, date_created)
        n += 1
      end
      return all_accounts
    end

    def self.find(id)
      result = Account.all.select {|account| account.id == id}
      # select method returns Array,which in our case
      # store only one element
      if result[0].nil?
        raise ArgumentError.new("Cannot find this ID in accounts")
      else
        return result[0]
      end
    end

    def add_owner(name, address, phone)
      @owner = Bank::Owner.new(name, address, phone)
    end

    def withdraw(amount)
      # TODO: implement withdraw
      if amount < 0
         raise ArgumentError.new("amount to withdraw cannot be less than 0")
      end
      if @balance - amount < 0
        puts "Warning: This ammount cannot be withdrawed; your balance cannot be negative"
      else
        @balance -= amount
      end
      puts "Your balance now is #{@balance}"
      return @balance
    end

    def deposit(amount)
      # TODO: implement deposit
      if amount < 0
         raise ArgumentError.new("amount to withdraw cannot be less than 0")
       end
      @balance += amount
      return @balance
    end
  end # end of class Account
end # end of module Bank


puts Bank::Account.all
#puts Bank::Account.find(9)
#puts Bank::Account.find(1213)
#
 #account = Bank::Account.new()
# puts account.withdraw(200)
# puts account.deposit(500)
# puts account.balance
# account.add_owner("Natalia", "000 Main Street", "4252959102")
# puts account.owner
# puts account.owner.name
