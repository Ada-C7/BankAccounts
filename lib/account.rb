require 'csv'
module Bank


  class Account

    def self.all
      account = []
      CSV.open("support/accounts.csv", "r").each do |account|
        id = Integer(account[0])
        balance = Integer(account[1])
        open_date = account[2]
        new_account = Account.new(id, balance, open_date)
        account << new_account
      end
      return account

    end

    def self.find(id)
      Account.all.each do |account|
        if account.id == id
          return account
        else
          puts "That acct DNE"
        end
      end
    end

    attr_reader :id, :balance
    def initialize(id, balance, open_date = nil)
      @id = id
      @balance = balance
      @open_date = open_date
      if @balance < 0
        raise ArgumentError.new "The starting balance cannot be negative"
      end
    end



    def withdraw(withdrawal_amount)
      if withdrawal_amount > @balance
        puts "Warning, the balance cannot be negative"
        @balance = @balance
      elsif withdrawal_amount < 0
        raise ArgumentError.new "You cannot withdraw a negative amount"
      else
        @balance -= withdrawal_amount
      end
    end

    def deposit(deposit_amount)
      #raise ArgumentError.new("amount must be >= 0") if amount < 0
      if deposit_amount < 0
        raise ArgumentError.new "The deposit must be greater than 0"

      else
        @balance += deposit_amount
      end
    end
  end
end
# def withdraw(amount)
#   raise ArgumentError.new("amount must be >= 0") if amount < 0
#
#   if @balance - amount < 0
#     puts "Oh no! Account will be negative"
#     return @balance
#   else
#     @balance -= amount
#   end
# end
