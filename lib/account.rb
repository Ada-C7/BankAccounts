require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :open_date
    def initialize(id, balance, open_date = "")
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
      @open_date = open_date
    end

    def withdraw(amount)
      balance_min = 0
      withdraw_internal(amount, balance_min)
    end

    def deposit(amount)
      raise ArgumentError.new("deposit must be > 0") if amount <= 0
      @balance += amount
    end

    def self.all
      accounts = []
      CSV.open("support/accounts.csv").each do |line|
        accounts << self.new(line[0].to_f/100, line[1].to_f/100, line[2])
      end
      return accounts
    end

    def self.find(id)
      self.all.each do |account|
        return account if account.id == id
      end
      raise ArgumentError.new("ID does not exist")
    end

    private
    
    def withdraw_internal(amount, balance_min)
      raise ArgumentError.new("withdrawl must be > 0") if amount <= 0
      if update_balance?(amount, balance_min)
        @balance -= amount
      end
      return @balance
    end

    def update_balance?(amount, balance_min)
      return true if @balance - amount >= balance_min
      puts "Requested withdrawl amount surpasses allowable account balance."
      return false
    end
  end
end
