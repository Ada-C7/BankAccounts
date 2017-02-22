require 'csv'
#Making class Account inside module Bank
module Bank
  #The account class takes an id and balance
  class Account

    #Class method that returns an array of Account objects
    def self.all
      account_array = []
      CSV.open("/Users/acgillette/Documents/dev_folder/ada_folder/ada_exercises/week_three/BankAccounts/support/accounts.csv", 'r').each do |account|
        id = account[1]
        balance = Integer(account[0])
        open_date = "#{account[3]}"
        new_account = Account.new(id, balance, open_date)
        account_array << new_account
      end
      return account_array
    end


    attr_reader :id
    attr_accessor :balance, :owner

    def initialize(id, balance, open_date=nil)
      @id = id
      #if the balance is negative, throw an error
      if balance >= 0
      @balance = balance
      else
        raise ArgumentError.new "The balance must be 0 or above"
      end
    end

    #Method to withdraw money from the account
    def withdraw(withdrawal)
      #Make sure the withdrawal is a positive number
      raise ArgumentError.new "The amount withdrawn must be  a positive number" if withdrawal < 0
      #Warn if the withdrawal will put the balance in the negative, and cancel
      #withdrawal if so
      if (@balance - withdrawal < 0)
        print "Warning! Withdrawing this amount will put your
        balance in the negative"
        return @balance
      else
        return @balance -= withdrawal
      end
    end

    #Method to deposit money into account
    def deposit(deposit)
      #Make sure the amount is a positive number
        raise ArgumentError.new "The deposit must be a positive amount" if deposit < 0

        @balance += deposit

    end

    #Add an owner object to the account. The owner has a name, address and
    #phone number
    def add_owner(owner)
      @owner = owner
    end

  end

end
