require 'csv'
require 'date'
require_relative 'owner'

module Bank
  class Account
    attr_reader :id, :balance, :date, :owner

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

    def add_owner(owner)
      if owner.class != Owner
        raise ArgumentError.new "Cannot accept an owner that is not of class Owner."
      end
      @owner = owner
    end

    def withdraw(withdrawal_amount)

      if withdrawal_amount <= 0 #throws error if withdrawal is not positive
        raise ArgumentError.new "You cannot withdraw a negative amount."

      elsif withdrawal_amount <= @balance
        @balance -= withdrawal_amount

      else #gives warning if withdrawal is more than balance
        puts "You cannot withdraw more than you have in your account."
        @balance
      end

    end

    def deposit(deposit_amount)

      if deposit_amount <= 0 #throws error if deposit is negative
        raise ArgumentError.new "You must deposit a positive amount."
      else
        @balance += deposit_amount
      end

    end

  end
end

# accounts = Bank::Account.all
# puts accounts
#
# puts Bank::Account.find(1212).date
