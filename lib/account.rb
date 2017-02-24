require 'csv'
require 'time'

module Bank
  class Account
    # attr_accessor :withdraw, :deposit, :all_accounts
    attr_reader :id, :balance, :opendate, :show_id, :account_count, :find_account
    @@count = 0

    def initialize(id, balance, opendate)
      @@count += 1
      @id = id.to_i
      @balance = monify(balance)
      unless @balance >= 0
        raise ArgumentError.new "Starting balance is not valid."
      end
      @opendate = Time.parse(opendate)
      @withdraw_fee = 0
      @minimum_balance = 0
      # @opendate = DateTime.strptime(opendate, '%Y-%m-%d %H:%M:%S %z')
    end

    # check if balance is in cents or in dollars with '.'
    def monify(amount)
      float_already = false
      amount.to_s.each_char do |letter|
        if letter == "."
          float_already = true
        else
        end
      end
      if float_already == false
        return amount.to_i/100.0
      else
        return amount.to_f
      end
    end

    def withdraw(amount)
      unless amount > 0
        raise ArgumentError.new "Withdrawal has be a positive amount!"
      end

      if @balance - (amount + @withdraw_fee) < @minimum_balance
        puts "Can't withdraw more than you have!"
      else
        @balance -= (amount + @withdraw_fee)
      end
      return @balance
    end

    def deposit(amount)
      unless amount > 0
        raise ArgumentError.new "Must deposit a positive amount!"
      end
      @balance += amount
      return @balance
    end

    def self.all
      @all_accounts = []
      CSV.foreach("../support/accounts.csv") do |row|
         @all_accounts << Account.new(row[0], row[1], row[2])
      end
      return @all_accounts
    end

    def self.find(id)
      @find_account = nil
      CSV.foreach("../support/accounts.csv") do |row|
        if row[0].to_i == id
          @find_account = Account.new(row[0], row[1], row[2])
        else
        end
      end
      if @find_account == nil
        raise ArgumentError.new("No matching account on file.")
      else
        return @find_account
      end
    end
  end
end
