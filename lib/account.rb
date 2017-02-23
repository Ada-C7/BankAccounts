require 'csv'
require 'ap'
module Bank
  class Account

    attr_reader :id, :balance, :open_date
    def initialize(id, balance, open_date ="")
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      @open_date = open_date

    end

    @@account_all = []

    @@csv = []
    CSV.read("./support/accounts.csv").each do |account|
      @@csv << {id: account[0].to_i, balance: account[1].to_i, open_date: account[2]}
    end


    def self.csv
      return @@csv
    end

    def self.find_csv_account(num)
      return @@csv[num]
    end


    @@csv.each do |account|
      @@account_all << self.new(account[:id].to_i, account[:balance].to_i, account[:open_date])
    end

    def self.all
      return @@account_all
    end


    def self.find(entered_id)
      id_exist = false
      @@account_all.each do |account|
        if account.id == entered_id
          return account
          id_exist = true
        end
      end
      if id_exist == false
        raise ArgumentError.new "Entered ID doesn't exist"
      end
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
