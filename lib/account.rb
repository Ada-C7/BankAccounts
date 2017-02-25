require 'csv'

module Bank

  class Account
    attr_accessor :id, :balance, :date
    def initialize (id, start_balance, date = nil)
      if start_balance < 0
        raise ArgumentError, 'You cannot use a negative number for your initial balance'
      end
      @id = id
      @balance = start_balance
      @date =  date
    end

    @accounts = []

    def self.all
      @accounts = []
      CSV.open("./support/accounts.csv").each do |line|
        @accounts << self.new(line[0].to_i, line[1].to_f, line[2].to_s)
      end
      return @accounts
    end

    def self.find(id)
      all.each do |account|
        if account.id == id
          return account
        end
      end
      raise ArgumentError.new("Account that doesn't exist")
    end

    def withdraw(amount)
      raise ArgumentError.new("You do not have sufficient funds, to complete this transaction") if amount < 0
      if @balance - amount < 0
        puts "Your account will be overdrawn"
        return @balance
      end
      @balance = @balance - amount
      return @balance
    end

    def deposit(amount)
      if amount < 0
        raise ArgumentError.new("You cannot deposit a negative number")
        return @balance
      end
      @balance = @balance + amount
      return @balance
    end
  end

end
