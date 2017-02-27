require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :owner

    def initialize(id, balance = 0)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
    end

      def self.all
      accounts = []
      CSV.read("support/accounts.csv").each do |line|
        accounts << Account.new(line[0], line[1].to_f/100)
      end
      return accounts
    end

    def self.find(id)
      CSV.read("support/accounts.csv").each do |line|
        if line[0] == id
          return Account.new(line[0], line[1].to_f/100)
        end
      end
      raise ArgumentError.new("account id doesn't exist")
    end


    def withdraw(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      if amount > @balance
        puts "Warning: insufficient fund."
      else
        @balance = @balance - amount
      end
      return @balance
    end
    def deposit(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      @balance = @balance + amount
      return @balance
      # @balance += amount
    end
    def add_owner (owner)
      @owner = owner
    end
  end

  class Owner
    attr_reader :id, :last_name, :first_name, :street_address, :city, :state
    def initialize(id, last_name, first_name, street_address, city, state)
      @id = id
      @last_name = last_name
      @first_name = first_name
      @street_address = street_address
      @city = city
      @state = state
    end

    def self.all
      owners = []
      CSV.read("support/owners.csv").each do |line|
        owners << Owner.new(line[0], line[1], line[2], line[3], line[4], line[5])
      end
      return owners
    end

    def self.find(id)
      CSV.read("support/owners.csv").each do |line|
        if line[0] == id
          return Owner.new(line[0], line[1], line[2], line[3], line[4], line[5])
        end
      end
      raise ArgumentError.new("owner id doesn't exist")
    end
  end
end
