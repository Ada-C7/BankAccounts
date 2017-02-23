# bank account that allows new accounts, deposit and withdrawals
# jou-jou sun
# last edit 2/21/17
require 'csv'

module Bank
  class Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id
      @balance = balance
        if @balance < 0
          raise ArgumentError.new "The starting balance must be positive"
        end
    end

    def withdraw(withdrawal_amount)
      if withdrawal_amount < 0
        raise ArgumentError.new "Withdrawal must be positive"
      end
      if withdrawal_amount > @balance
        print "Account will be in negative with this withdrawal"
        return @balance
      else
        @balance -= withdrawal_amount
        return @balance
      end
    end

    def deposit(deposit)
      if deposit < 0
        raise ArgumentError.new "Deposit must be positive"
      end
      @balance += deposit
      return @balance
    end


    def self.all
      accounts_array = []

      each_account = CSV.open("/Users/jou-jousun/ada/projects/BankAccounts/support/accounts.csv")

      each_account.each do |account|
        accounts_array << Account.new(account[0].to_i, account[1].to_i)

      return accounts_array
      end
      #get info from CSV
      #create new instances of Accounts
      #push each new Account instances into an accounts_array
      #return the array
    end
  end #end of class

end #end of module
