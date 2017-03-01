require_relative 'owner'
require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :opendate, :owner

    def initialize id, balance, opendate = "1999-03-27 11:30:09 -0800"
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError.new "Initial balance must be more than zero."
      end

      @opendate = opendate
      @owner = find_owner
    end

    def find_owner #I know this could be written in a much shorter way but it.would.not.work so i broke it out into smaller pieces
      owner_index = nil

      CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/account_owners.csv").each do |line|
        if line[0].to_i == @id
          owner_index = line[1].to_i
          # @owner = Bank::Owner.find(line[1].to_i)
        end
      end

      if owner_index != nil
        return @owner = Bank::Owner.find(owner_index)
      else
        puts "Owner info not found; blank owner info created"
        return @owner = Bank::Owner.new("N/A", "N/A", "N/A", "N/A", "N/A", "N/A")
      end
    end


    def self.all  #reads in csv file and returns collection of Account instances
      accounts = []

      CSV.read("/Users/sai/Documents/ada/projects/BankAccounts/support/accounts.csv").each do |line|
        accounts << Account.new(line[0].to_i, line[1].to_i, line[2])
      end

      return accounts
    end

    def self.find(id) #returns an instance of Account that matches the passed id parameter
      all_accounts = Account.all
      account_found = false

      all_accounts.each do |account|
        if account.id == id
          account_found = true
          return account
        end
      end

      if !account_found
        puts "ID not found"
      end
    end

    def withdraw(new_withdrawal)
      # raise ArgumentError.new("You must withdraw a positive amount") if new_withdrawal < 0 #alternate if statement for one-line conditional
      if new_withdrawal <=0
        raise ArgumentError.new "withdrawal must be greater than 0"
      elsif new_withdrawal > @balance
        puts "Insufficient funds"  #puts statement returns nil
        @balance #this is what is returned by this elsif
      else
        @balance -= new_withdrawal
      end
    end

    def deposit(new_deposit)
      if new_deposit <= 0
        raise ArgumentError.new "deposit amount must be greater than 0"
      else
        @balance += new_deposit
      end
    end
        
  end
end
