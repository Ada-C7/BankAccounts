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

    @@csv = []

    def self.read_csv
        @@csv = []
      CSV.read("./support/accounts.csv").each do |account|
        @@csv << {id: account[0].to_i, balance: account[1].to_i, open_date: account[2]}
      end
      return @@csv
    end

    # @@csv = CSV.read("./support/accounts.csv")
    #
    # def self.read_csv
    #   return @@csv
    # end
    #



    def self.all
      @@account_all = []
      self.read_csv.each do |account|
        @@account_all << self.new(account[:id].to_i, account[:balance].to_i, account[:open_date])
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
# puts Bank::Account.all[0].id
# puts Bank::Account.read_csv[0][:id]
# puts Bank::Account.read_csv
