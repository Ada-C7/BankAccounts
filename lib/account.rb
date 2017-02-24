
# require "awesome_print"
require 'csv'

# Baseline
module Bank

  class Owner
    attr_reader :id

    def initialize(owner_id, name_first, name_last, address_street, address_city, address_state)
      @id = owner_id
      @name_first = name_first
      @name_last = name_last
      @name = name
      @address_street = address_street
      @address_city = address_city
      @address_state = address_state
      #@@all_owners << self
    end

    def self.all
      all_owners_array = []
      CSV.read("support/owners.csv").each do |line|
        id = line[0].to_i
        last = line[1]
        first = line[2]
        street = line[3]
        city = line[4]
        state = line[5]
        all_owners_array << Owner.new(id, first, last, street, city, state)
      end

      def self.find(id)
        all_owners_array = Bank::Owner.all
        all_owners_array.each do |owner_instance|
          return owner_instance if owner_instance.id == id
        end
        raise ArgumentError.new "Owner #{id} does not exist!!"
      end

    end

    def name
      @name_first + " " + @name_last
    end

    def address
      @address_street + ", " + @address_city + ", " + @address_state
    end
  end

  class Account

    attr_reader :balance, :id, :open_date
    attr_accessor :owner_id
    # @@all_accounts = []

    def initialize (id, initial_balance, open_date, owner_id = -1)

      raise ArgumentError.new "An account can't be created with negative balance" if initial_balance < 0

      @id = id
      @balance = initial_balance
      @open_date = open_date
      @owner_id = owner_id

      #@@all_accounts << self #instance
    end

    def self.all
      all_accounts_array = []
      CSV.read("support/accounts.csv").each do |line|
        id = line[0].to_i
        balance = line[1].to_i/100.0
        open_date = line[2]
        all_accounts_array << Bank::Account.new(id, balance, open_date)
      end
      return all_accounts_array
    end

    def self.find(id)
      all_accounts_array = Bank::Account.all #also works as = self.all
      all_accounts_array.each do |account_instance|
        return account_instance if account_instance.id == id
      end
      raise ArgumentError.new "Account: #{id} does not exist"
    end

    def withdraw(amount)
      raise ArgumentError.new "Invalid negative amount" if amount < 0

      if amount > @balance
        puts "You don't have sufficient funds. Max withdrawel amount is #{@balance}."
      else
        @balance -= amount
      end

      return @balance
    end

    def deposit(amount)
      raise ArgumentError.new "Invalid negative amount" if amount < 0
      @balance += amount
      return @balance
    end
  end

end

#puts Bank::Account.find(1212).inspect
# puts Bank::Account.all.inspect
# puts Bank::Account.all.length

# Bank::Owner.import_owners_csv("../support/owners.csv")
# puts Bank::Owner.all.inspect
# puts Bank::Owner.all.length


#newaccount2 = Bank::Account.new(3333, 22222, "2222-03-27")
