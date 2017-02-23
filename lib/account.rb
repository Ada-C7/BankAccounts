require 'csv'

module Bank
  class Account
    attr_reader :id
    attr_accessor :balance


    # should get info from csv
    # create new instances of Account based on the csv info
    # create an array of Account instances
    # and return it
    def self.all
      accounts_array = CSV.read("/Users/alena/Documents/Ada/projects/BankAccounts/support/accounts.csv")

      new_accounts = []

      accounts_array.each do |line|
        new_accounts << Account.new(line[0].to_i, line[1].to_i)
      end
      return new_accounts
    end

    def initialize id, start_balance
      # raise ArgumentError.new("amount must be >= 0") is amount < 0

      @id = id

      if start_balance >= 0
        @balance = start_balance
      else raise ArgumentError.new
      end
    end

    def withdraw(withdrawal_amount)
      # dont need an else beacuse it stops the program

      # raise ArgumentError.new("amount must be >= 0") is amount < 0
      if withdrawal_amount < 0
        raise ArgumentError.new
      elsif withdrawal_amount > @balance
        print "You are withdrawing too much!"
        return @balance
      else
        @balance -= withdrawal_amount
      end

    end

    def deposit(deposit_amount)
      # raise ArgumentError.new("amount must be >= 0") is amount < 0
      if deposit_amount < 0
        raise ArgumentError.new
      end

      @balance += deposit_amount
    end

  end
end

puts Bank::Account.all
