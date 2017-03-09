require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :open_date
    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
      @open_date = open_date
    end

    def self.all
      all_accounts = []

      CSV.read("./support/accounts.csv").each do |account_line|
        id = account_line[0].to_i
        balance = account_line[1].to_i
        open_date = account_line[2]

        account = Bank::Account.new(id, balance, open_date)
        all_accounts << account
      end
      return all_accounts
    end

    def self.find(id)
      accounts = Bank::Account.all

      accounts.each do |account|
        if account.id == id
          return account
        end
      end

      raise ArgumentError.new "Account does not exist"

    end

    def withdraw(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      new_balance = balance - amount
      if new_balance < 0
        print "Something"
      else
        @balance = new_balance
      end
      return @balance
    end

    def deposit(amount)
      raise ArgumentError.new("amount must be >= 0") if amount < 0
      new_balance = balance + amount
      @balance = new_balance
      return @balance
    end
  end # end of class Account
end # end of module Bank
