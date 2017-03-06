require 'csv'
require 'pry'



module Bank

  class Account

    attr_accessor :balance
    attr_accessor :id, :opendatetime#, :accounts

    @@accounts = nil
    def initialize(account_hash)

      @id = account_hash[:id].to_i
      @balance = account_hash[:balance].to_i
      @opendatetime = account_hash[:opendatetime]

      raise ArgumentError.new "Account balance should not start with a negative number" if @balance < 0
      @balance = @balance

    end #end of initialize


    def self.all

      if @@accounts == nil

        @@accounts = []

        CSV.read("support/accounts.csv").each do |row|
          account = {
            id: row[0],
            balance: row[1],
            opendatetime: row[2]
          }

          @@accounts << Bank::Account.new(account)

        end
      end
      return @@accounts
    end #end self.all


    # def self.accounts
    #   @@accounts #= @@accounts
    # end


    def self.find(id)

      @@accounts.find do |account|

        if account.id == id
          return account
        end
      end

      raise ArgumentError.new "#{id} returned no results"
    end #end self.find


    def withdraw(amount)

      if amount < 0
        raise ArgumentError.new "Withdrawal amount cannot be negative number"
      else
        if @balance < amount
          print "Your account is going to be overdrawn"
          @balance = @balance
        elsif @balance >= amount
          return @balance -= amount
        end
      end
    end #end of withdraw method

    def deposit(deposit_amount)

      if deposit_amount < 0
        raise ArgumentError.new "Deposit amount cannot be negative number"
      else
        @balance += deposit_amount
      end
    end #end of deposit method


  end #end of class

end #end of module
