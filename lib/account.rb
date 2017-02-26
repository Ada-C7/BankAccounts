require 'csv'

module Bank
  class Account
    attr_reader :id
    attr_accessor :balance

    def self.all
      accounts_array = CSV.read("support/accounts.csv")
      new_accounts = []

      accounts_array.each do |line|
        new_accounts << Account.new(line[0].to_i, line[1].to_i)
      end

      return new_accounts
    end

    def self.find(id)

      Account.all.each do |account|
        if account.id == id
          return account
        end
      end

      raise ArgumentError.new "Account: #{id} does not exist"
    end

    def initialize(id, start_balance)

      @id = id

      if start_balance >= 0
        @balance = start_balance
      else raise ArgumentError.new "New balance must be equal or greater than 0"
      end
    end

    def withdraw(withdrawal_amount)

      if withdrawal_amount < 0
        raise ArgumentError.new "Withdrawal amount must be positive"
      elsif withdrawal_amount > @balance
        print "You are withdrawing too much!"
        return @balance
      else
        @balance -= withdrawal_amount
      end

    end

    def deposit(deposit_amount)

      if deposit_amount < 0
        raise ArgumentError.new "Deposit amount must be positive"
      end

      @balance += deposit_amount
    end

  end
end
