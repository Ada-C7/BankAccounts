require_relative 'owner'
require 'csv'
require 'date'

module Bank
  class Account
    attr_accessor :id, :balance, :owner, :date_created
    # To make all given tests pass, default values was given for some paramethers
    def initialize(id, balance, date_created = "1991-01-01 11:01:01 -0800", owner=nil)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      @owner = owner
    end

    # Returns array of all instances of class Account
    def self.all
      csv = CSV.read("../support/accounts.csv", 'r') # object of class CSV
      all_accounts = []
      n = 0 # current line of csv file
      csv.length.times do
        id = csv[n][0].to_i
        balance = csv[n][1].to_i/100.0 # /100.0 to convert cents to dollar
        date_created = DateTime.parse(csv[n][2])
        all_accounts << Account.new(id, balance, date_created)
        n += 1
      end
      return all_accounts
    end

    def self.find(id)
      result = Account.all.select {|account| account.id == id}
      # select method returns array, which in our case will
      # store only one element (cannot be two account with same id)
      if result[0].nil?
        raise ArgumentError.new("Cannot find this ID in accounts")
      else
        return result[0]
      end
    end
    # Method returns array of all accounts, with  @owner
    # instance variable, that stores corresponding owner
    # of account (from account_owners.csv file)
    def self.accounts_with_owners
      accounts_with_owners = []
      csv = CSV.read("../support/account_owners.csv", 'r')
      csv.each do |line|
        # Match account instance with id in csv file
        account = Bank::Account.find(line[0].to_i)
        # Match account.owner with id in csv file
        account.owner = Bank::Owner.find(line[1].to_i)
        # Add new account to array
        accounts_with_owners << account
      end
    end
    # Add owner attribute to account
    def add_owner(id, last_name)
      @owner = Bank::Owner.new(id, last_name)
    end

    # method Account#withdraw is interface for withdraw_internal method
    # I did it to be able use inheritance
    # without changing my tests in CheckingAccount
    # and SavingsAccount classes (see these classes for details)

    # SavingsAccount and CheckingsAccount withdraw methods
    # inherits from Account withdraw, so I added
    # fee and minimum_balance default paramethers,
    # that will be default for Bank::Account class
    # but not default for Savings and CheckingAccount
    def withdraw(amount, fee=0, minimum_balance=0)
      withdraw_internal(amount, fee, minimum_balance)
    end

    def withdraw_internal(amount, fee=0, minimum_balance = 0)
      if amount < 0
         raise ArgumentError.new("amount to withdraw cannot be less than 0")
      end
      if @balance - amount - fee < minimum_balance
        puts "Warning: This amount cannot be withdrawed;
         your balance cannot be less than #{minimum_balance}$"
      else
        @balance = @balance - amount - fee
      end
      puts "Your balance now is #{@balance}$"
      return @balance
    end

    def deposit(amount)
      if amount < 0
         raise ArgumentError.new("amount to withdraw cannot be less than 0")
       end
      @balance += amount
      return @balance
    end

  end # end of class Account
end # end of module Bank
