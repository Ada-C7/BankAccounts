require 'csv'
#require_relative 'owner'

module Bank
  class Account
    attr_reader :id, :balance

    def self.all
      accounts = []
      CSV.read("support/accounts.csv").each do |line|
        accounts << Bank::Account.new(line[0], line[1].to_f)
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

    def initialize(id, balance)
      @id = id

      if balance < 0 #throws error if negative balance is given
        raise ArgumentError.new "Balance cannot be negative"
      else
        @balance = balance
      end

    end

    def withdraw(withdrawal_amount)

      if withdrawal_amount < 0 #throws error if withdrawal is negative
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

#accounts = Bank::Account.all

puts Bank::Account.find("1212").id
