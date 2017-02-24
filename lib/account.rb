require 'csv'

module Bank
  class Account
    attr_reader :id, :balance, :openDate
    def initialize(id, balance, openDate = '1999-03-27 11:30:09 -0800')
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id
      @balance = balance
      @openDate = openDate
    end

    def self.all
      all_accounts = [] #array of classes
      #iterate /new accounts objects
      CSV.open("./support/accounts.csv").each do |line|

        # all_accounts << Bank::Account.new(line[0].to_i,line[1].to_i,line[2])
        all_accounts << self.new(line[0].to_i,line[1].to_i,line[2])
      end
      return all_accounts
    end

    def self.find(id) #looking all_account finding matches with id
      self.all.each do |account| #account - a class
        if account.id == id
          return account
        end
      end
      raise ArgumentError.new("id must be account id") #No clause on this one because if the "each" loop ends, without returning an account, then there are no id numbers that match ahe accounts. So, if the "each" loop ends, then the ArgumentError triggers because there are no ids.
    end


    def withdraw(amount)
      raise ArgumentError.new("amount must be > 0") if amount < 0 #the clause at the end of this ArgumentError triggers the error when the "if" statement is true. If the "if" clause is not true, it skips.
      @balance -= amount
      if @balance < 0
        puts "You can't withdraw!"
        @balance += amount
      end
      return @balance
    end

    def deposit(amount)
      raise ArgumentError.new("amount must be > 0") if amount < 0
      @balance += amount
    end
  end
end


#new_account = Bank::Account.new(1234, 2000)
#new_account =  Bank::Account.all
# puts Bank::Account.all
#puts Bank::Account.find(1212).id
