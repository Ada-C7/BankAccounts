
require 'csv'


module Bank

  class Account

    attr_reader :id
    attr_accessor :balance


    def initialize(account_hash)

        @id = account_hash[:id]
        @balance = account_hash[:balance].to_f
        @opendatetime = account_hash[:opendatetime]

      if @balance >= 0
        @balance = @balance
      else
        raise ArgumentError.new "Account balance should not start with a negative number"
      end

    end #end of initialize

    def self.all
      accounts = []
      CSV.read("support/accounts.csv").each do |row|
         account = {
           id: row[0],
           balance: row[1],
           opendatetime: row[2]
         }

         accounts << Account.new(account)
      end
    end

    def self.find(account_info)
      self.all do |account|
        if account.include? account_info
          print true
        else
          print false
        end
      end
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
Bank::Account.find(id: "1213")
