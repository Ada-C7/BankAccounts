require 'csv'
require 'ap'
module Bank
  class Account

    attr_reader :id, :balance, :open_date, :num_of_accounts
    def initialize(id, balance, open_date ="")
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      @open_date = open_date

    end

    @@account_all = []
    @@csv = CSV.read("./support/accounts.csv")

    def self.read_csv
      return @@csv
    end




    def self.all
      @@account_all = []
      @@csv.each do |account|
        @@account_all << self.new(account[0].to_i, account[1].to_i, account[2])
      end
      return @@account_all
    end

    def withdraw(amount)
      if amount < 0
        raise ArgumentError.new "Negative amount entered for withdrawal"
      else
        new_balance = @balance - amount
        if new_balance < 0
          puts "Withdrawal amount greater than the current balance"
          @balance = @balance
        else
        @balance = new_balance
        end
      end
    end

    def deposit(amount)
      if amount < 0
        raise ArgumentError.new "Minus amount deposited"
      else
        new_balance = @balance + amount
        @balance = new_balance
      end

    end

  end
end
