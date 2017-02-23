
# require "awesome_print"
require 'csv'

# Baseline
module Bank

  class Owner
    attr_reader :id, :name, :address
    @@all_owners = []

    def initialize(owner_id, name_first, name_last, address_street, address_city, address_state)
      @id = owner_id
      @name_first = name_first
      @name_last = name_last
      @name = name
      @address_street = address_street
      @address_city = address_city
      @address_state = address_state

      @@all_owners << self

    end

    def self.all
      return @@all_owners
    end

    def self.find(id)
      @@all_owners.each do |owner|
        return owner if owner.id = id
      end

      raise ArgumentError.new "owner #{id} does not exist!!"
    end

    def self.import_owners_csv(filename)
      require 'csv'
      CSV.open(filename, 'r').each do |line|
        id = line[0].to_i
        last = line[1]
        first = line[2]
        street = line[3]
        city = line[4]
        state = line[5]

        Owner.new(id, first, last, street, city, state)
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
        all_accounts = []
        CSV.open("support/accounts.csv", 'r').each do |line|
          id = line[0].to_i
          balance = line[1].to_i
          open_date = line[2]
          account = Bank::Account.new(id, balance, open_date)
          all_accounts << account
        end
          return all_accounts
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
# puts Bank::Account.all.inspect
# puts Bank::Account.all.length

# Bank::Owner.import_owners_csv("../support/owners.csv")
# puts Bank::Owner.all.inspect
# puts Bank::Owner.all.length


#newaccount2 = Bank::Account.new(3333, 22222, "2222-03-27")
