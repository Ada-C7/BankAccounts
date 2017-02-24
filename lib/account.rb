require 'csv'
module Bank
  class Account
    attr_reader :id, :balance, :open_date

    def initialize(id, balance, open_date = nil) #the equal to nil is so the other wave one tests pass
      raise ArgumentError.new("balance must be >= 0") if balance < 0

      @id = id
      @balance = balance
      @open_date = open_date

    end

    def self.all
      accounts = []
      CSV.read("support/accounts.csv").each do |object|
        id =  object[0].to_i
        balance = object[1].to_f/100
        open_date = object[2]
        a_account = Bank::Account.new(id, balance, open_date)
        accounts << a_account
        end
        print  accounts
        return accounts
    end

    def self.find(id)
      a_account = Bank::Account.all
      a_account.each do |object|
        if object.id == id
        return object
        end
      end
       raise ArgumentError.new "Account: #{id} does not exist"
    end


    def withdraw(amount)
      raise ArgumentError.new("Withdraw amount must be a positive integer") if amount < 0
      if @balance < amount
        puts "Warning: desired withdrawl amount exceeds account balance."
        return @balance
      else
        @balance -= amount
        return @balance
      end
    end

    def deposit(amount)
      raise ArgumentError.new("Deposit amount must be a positive integer") if amount < 0
      @balance += amount
      return @balance
    end
  end
end

# account_1 = Bank::Account.new(1212, 1235667, "1999-03-27 11:30:09 -0800")
# Bank::Account.all
Bank::Account.find(1212)
