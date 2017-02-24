require 'csv'
require 'date'

module Bank
  class Account

    attr_reader :id, :balance, :owner, :open_date

    def initialize(account_info)
      raise ArgumentError.new("Balance cannot be negative.") if account_info[:balance] < 0

      @id = account_info[:id].to_i
      @balance = account_info[:balance].to_f
      @open_date = DateTime.parse(account_info[:open_date]) unless account_info[:open_date].nil?
      @owner = account_info[:owner]
    end

    def self.all
      accounts_to_owners = {}
      CSV.read("support/account_owners.csv").each do |line|
        accounts_to_owners[ line[0].to_i ] = line[1].to_i
      end

      CSV.read("support/accounts.csv").collect do |account|
        Account.new(
          id: account[0].to_i,
          balance: account[1].to_f/100,
          open_date: account[2],
          owner: Owner.find(accounts_to_owners[account[0].to_i])
        )
      end
    end

    def self.find(id)
      target = Account.all.select { |account| account.id == id }[0]

      raise ArgumentError.new("Invalid account ID.") if target.nil?
      target
    end

    def add_owner owner
      if @owner.nil?
        @owner = owner
      else
        raise ArgumentError.new("The account already has an owner.")
      end
    end

    def withdraw(amount)
      raise ArgumentError.new("The withdrawal amount must be positive.") if amount < 0

      if amount > @balance
        puts "Insufficient Funds"
        @balance
      else
        @balance -= amount
      end
    end

    def deposit(amount)
      raise ArgumentError.new("The deposit amount must be positive.") if amount < 0

      @balance += amount
    end

  end
end
