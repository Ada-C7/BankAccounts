require 'CSV'

module Bank

  class Account

    attr_accessor :id, :balance, :created

    def initialize(id, balance, created = nil)

      raise ArgumentError.new "Balance must be positive or 0" unless balance >= 0
      @id = id
      @balance = balance
      @created = created
    end

    def self.all
      accounts = []

      CSV.read("accounts.csv").each do |line|
        id = line[0].to_i
        balance = line[1].to_i
        created = line[2]

        account = Bank::Account.new(id, balance, created)

        accounts << account
      end

      accounts
    end

    def self.find(id)

      accounts = Bank::Account.all

      accounts.each do |account|
        if account.id == id
          return account
        end
      end

      raise ArgumentError.new "Account: #{id} does not exist"
    end


    def withdraw(amount)
      raise ArgumentError.new if amount < 0

      if amount > balance
        puts "That would bring the balance below 0"
      else
        @balance = @balance - amount
      end

      balance
    end

    def deposit(amount)
      raise ArgumentError.new if amount < 0
      @balance += amount
    end
  end

  # class SavingsAccount < Account
  #   attr_accessor :interest_rate
  #
  #   def initialize( id, balance, interest_rate = 0.25)
  #     raise ArgumentError.new "Balance must be more than 10" unless balance > 1000
  #     if balance > 1000
  #       super(id, balance)
  #
  #       @interest_rate = interest_rate
  #     end
  #   end #this is for initialize
  #
  #   def withdraw(amount)
  #     raise ArgumentError.new if amount < 0
  #
  #     #check that balance after will exceed 10 + $2 fee
  #     if @balance - amount - 200 < 1000
  #       puts "Sorry, minimum $10 balance."
  #     else
  #       @balance = @balance - amount - 200
  #     end
  #     @balance
  #   end #withdraw end
  #
  #   #add interst to savings
  #   def add_interest(rate = @interest_rate)
  #
  #     total_interst = @balance * rate/100
  #     @balance += total_interst
  #     return total_interst
  #
  #   end #This is for add_interest
  #
  # end # This is for the class

  # class CheckingAccount < Account
  #   attr_accessor :checks_used
  #
  #   def initialize( id, balance, checks_used = 0)
  #     super(id, balance)
  #     @checks_used = checks_used
  #
  #   end #this is for initialize
  #
  #
  #   def withdraw(amount)
  #     raise ArgumentError.new if amount < 0
  #
  #     if @balance - amount - 100 < -1000
  #       puts "Sorry, minimum $10 balance."
  #     else
  #       @balance = @balance - amount - 100
  #     end
  #     @balance
  #   end #withdraw end
  #
  #   def withdraw_using_check(amount)
  #     @checks_used += 1
  #     if @checks_used <= 3
  #       fee = 0
  #     else
  #       fee = 200
  #     end
  #     puts @checks_used
  #     puts fee
  #     if @balance - amount - fee < - 1000
  #       puts " Warning, only allowed $10 overdraft"
  #     else
  #       @balance -= amount + fee
  #
  #     end # this is for if
  #
  #     @balance
  #
  #
  #
  #   end # end for withdraw
  #
  #
  #   def reset_checks
  #     @checks_used = 0
  #   end # reset checks end
  #
  #
  #
  #
  #
  # end # This is for the class
  #
  # raise ArgumentError.new "Balance must be more than 10" unless balance > 1000

  lisy = Account.new(123, 1000)
  # puts lisy.withdraw(2000)
puts lisy.balance 


end # This is for the bank module
