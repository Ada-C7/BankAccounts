require 'csv'

module Bank
  class Account

    attr_reader :balance, :id, :open_date
#can self.all be refactored if for no other reason than my understanding
    def self.all
      new_account_info = []
      accounts_master = CSV.read("../support/accounts.csv")
      accounts_master.each do |account_array|
        id = account_array[0].to_i
        balance = account_array[1].to_i
        date = account_array[2]
        new_account_info << Account.new(id, balance, date)
        #  end_with_object(self).to_a
        @opening_balance 
      end
      return new_account_info
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

    def initialize(id, balance, open_date = nil)
      raise ArgumentError.new "Balance must be positive or 0" unless balance >= 0
      @id = id
      @balance = balance
      @open_date = open_date
    end

    def opening_balance(balance)
      if @opening_balance >= 0
        @opening_balance
      else
        raise ArgumentError.new "You can only open a new account with real money:)"
      end
    end

    def withdraw(amount_to_withdraw)
      if amount_to_withdraw > @balance
        raise ArgumentError.new "Insufficient funds. Your balance is #{@balance}"
      elsif amount_to_withdraw < 0
        raise ArgumentError.new "Withdraw amount must be a positive number."
      else
        @balance -= amount_to_withdraw
      end
      return @balance
    end

    def deposit(amount_to_deposit)
      if amount_to_deposit < 0
        raise ArgumentError.new "You must deposit real money."
      else
        @balance += amount_to_deposit
      end
    end
  end
end

#Sself.find(id) #- returns an instance of Account where the value of the id field in the CSV matches the passed parameter.



#SAVINGS ACCOUNT


require_relative 'account'

module Bank

  class SavingsAccount < Bank::Account

    def initialize(id, balance, date)
          super(id, balance, date)
          raise ArgumentError.new("You can only open a new account with at least $10.00") if balance < 1000
      @min_balance = 0
      @fee = 200
      #@account = Bank::SavingsAccount.new
    end

    def withdraw_fee(amount)
      if @balance - amount - @fee < @min_balance
        puts "This withdral would bring you below required minimum balance."
      else
        @balance -= amount + @fee
      end
      return @balance
    end

    def add_interest(rate)
      raise ArgumentError.new("You can only use positive value") if rate < 0
      interest = @balance * rate
      @balance += interest
      return interest
    end
  end
end

# def check_min_balance(amount)
#   if @min_balance < 10
#     raise ArgumentError.new "You can only open a new account with at least $10.00"
#   else
#     return "Great job. New savings account."
#   end
# end



#CHECKING ACCOUNT


module Bank

  class CheckingAccount < Bank::Account

    def initialize(id, balance, date)
      super(id, balance, date)
      @@min_balance = 0
      @@check_min_balance = -1000
      @fee = 100
    end
  end
end

def withdraw_math(amount)
  if @balance - amount - @fee > @@min_balance
    puts "This withdral plus withdraw fee would bring you below required minimum balance of #{@@min_balance}."
    raise ArgumentError.new "Insufficient funds. Your balance is #{@balance}"
  else
    @balance -= amount + @fee
  end
  return "Your balance after withdrawl is #{@balance}."
end

def withdraw(amount_to_withdraw)
  if amount_to_withdraw > @balance
    raise ArgumentError.new "Insufficient funds. Your balance is #{@balance}"
  elsif amount_to_withdraw < 0
    raise ArgumentError.new "Withdraw amount must be a positive number."
  else
    @balance -= amount_to_withdraw
    return "Your balance after withdrawl is #{@balance}."
  end
end

def check_withdraw
  if amount_to_withdraw > @balance - 10
    raise ArgumentError.new "We can't honor your check. Your balance is #{@balance}"
  elsif
    amount_to_withdraw > @balance && >= @balance + -10
    puts "This check with overdraft your account. Are you sure you want to write it?"
  end


  def self.withdraw_using_check(number)
    checks_written = []
    while checks_written is =< 3
    elsif
      checks_written >= 3
      checks == @balance - 200
      #for each loop here
      #checks_written.each do |fee|
        #i += 1
        @balance -= 2.00
      end
      reset_checks = checks_written(0)
    end
