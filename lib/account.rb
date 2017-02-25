require 'csv'
require 'date'
require_relative 'owner'

module Bank
  class Account
    attr_reader :id, :balance, :date, :owner

    def initialize(id, balance, date)
      raise ArgumentError.new "ID must be an Integer" if id.class != Integer
      @id = id

      if balance < 0 || balance.class != Integer
        raise ArgumentError.new "Balance must be a non-negative number"
      end
      @balance = balance

      @date = DateTime.parse(date)

      CSV.read("support/account_owners.csv").each do |line|
        if line[0].to_i == @id
          @owner = Bank::Owner.find(line[1].to_i)
        end
      end
    end

    def self.all
      accounts = []
      CSV.read("support/accounts.csv").each do |line|
        accounts << Bank::Account.new(line[0].to_i, line[1].to_i, line[2])
      end
      return accounts
    end

    def self.find(id)
      accounts = Bank::Account.all
      accounts.each do |account|
        return account if id == account.id
      end
      raise ArgumentError.new("Account does not exist")
    end

    def add_owner(owner)
      if owner.class != Owner
        raise ArgumentError.new "Cannot accept an owner that is not of class Owner."
      end
      @owner = owner
    end

    def withdraw(withdrawal_amount)
      raise ArgumentError.new "You cannot withdraw a negative amount." if withdrawal_amount <= 0

      return @balance -= withdrawal_amount if withdrawal_amount <= @balance

      puts "You cannot withdraw more than you have in your account."
      balance

    end

    def deposit(deposit_amount)
      raise ArgumentError.new "You must deposit a positive amount." if deposit_amount <= 0

      return @balance += deposit_amount
    end
  end
end
