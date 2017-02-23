require 'csv'

module Bank

  class Account
    attr_accessor :balance, :owner
    attr_reader :id

    def initialize(id, balance, opendate = "nodate")
      @id = id
      @opendate = opendate

      if balance < 0
        raise ArgumentError.new "You cannot initialize a new account with a negative balance."
      else
        @balance = balance
      end
    end

    def self.all
      accounts = []

      CSV.open("support/accounts.csv").each do |account|
        accounts << Bank::Account.new(account[0].to_i, account[1].to_i, account[2])
      end
      return accounts
    end

    def self.find(id)
      @account = nil
      CSV.open("support/accounts.csv").each do |line|
        if line[0].to_i == id
          @account = Bank::Account.new(line[0].to_i, line[1].to_i, line[2])
        end
      end

      if @account == nil
        raise ArgumentError.new "This account doee not exist!"
      else
        return @account
      end
    end

    def add_owner(owner)
      if owner.class == Owner
        @owner = owner
      else
        raise ArgumentError.new "You must add a class type of Owner."
      end
    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new("Withdrawal must be >=0") if withdrawal_amount < 0

      if @balance - withdrawal_amount < 0
        puts "You are going negative."
        return @balance
      else
        @balance -= withdrawal_amount
      end
    end

    def deposit(deposit_amount)
      if deposit_amount > 0
        @balance += deposit_amount
      else
        raise ArgumentError.new "Your deposit must be greater than zero."
      end
    end

  end

  class Owner
    attr_reader :last_name, :first_name, :street_address

    def initialize(id = nil, last_name = nil, first_name = nil, street_address = nil, city = nil, state = nil)
      id = id
      @last_name = last_name
      @first_name = first_name
      @street_address = street_address
      city = city
      state = state
    end

    def self.all
      owners = []
      CSV.open("support/owners.csv").each do |owner|
        owners << Bank::Owner.new(owner[0].to_i, owner[1], owner[2], owner[3], owner[4], owner[5])
      end
      return owners
    end

    def self.find(id)
      @owner = nil
      CSV.open("support/owners.csv").each do |owner|
        if owner[0].to_i == id
          @owner = Bank::Owner.new(owner[0].to_i, owner[1], owner[2], owner[3], owner[4], owner[5])
        end
      end
      return @owner
    end
  end
end

# my_account = Bank::Account.new(1212,1235667,"1999-03-27 11:30:09 -0800")
#
# puts my_account.balance

puts " #{ Bank::Account.all.class } "
