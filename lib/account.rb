
require 'csv'
require 'pry'



module Bank

  class Account




    attr_accessor :balance, :id, :opendatetime


    def initialize(account_hash)

      @id = account_hash[:id].to_i
      @balance = account_hash[:balance].to_i #currently this will assign a negaitve number
      @opendatetime = account_hash[:opendatetime]

      #method open_account assign to instance v.
      if @balance >= 0
        @balance = @balance
      else
        raise ArgumentError.new "Account balance should not start with a negative number"
      end

    end #end of initialize


    ### look into class var. or other way to save accounts
    def self.all
      accounts = []
      CSV.read("support/accounts.csv").each do |row|
        account = {
          id: row[0],
          balance: row[1],
          opendatetime: row[2]
        }

        accounts << Bank::Account.new(account)
      end
      return accounts
    end

    def self.find(id)

      accounts = Bank::Account.all

      accounts.find do |account|

        if account.id == id
          return account
        end
      end
      raise ArgumentError.new "#{id} returned no results"
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount < 0
        raise ArgumentError.new "Withdrawal amount cannot be negative number"
      else
        if @balance < withdrawal_amount
          print "Your account is going to be overdrawn"
          @balance = @balance
        elsif @balance >= withdrawal_amount
          return @balance -= withdrawal_amount
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

#puts Bank::Account.all.class
 # new_account = Bank::Account.new(id: 1212, balance: 1235667, opendatetime: "1999-03-27 11:30:09 -0800")
 # puts new_account.id
 # puts Bank::Account.all.id
# puts "These are all the Bank accounts: #{Bank::Account.all}"
#print Bank::Account.find(15115)
