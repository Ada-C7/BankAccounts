require_relative '../lib/account'
require 'csv'
require 'date'
module Bank
  class SavingsAccount < Account

    def initialize(id, balance)
      super(id, balance)
      raise ArgumentError.new("balance must be >= 10$") if balance < 10
    end

    def withdraw(amount)
      if amount < 0
         raise ArgumentError.new("amount to withdraw cannot be less than 0")
      end
      if @balance - amount - 2 < 10
        puts "Warning: This ammount cannot be withdrawed;
        your balance cannot be less than 10$"
      else
        @balance = @balance - amount - 2
      end
      puts "Your current balance is #{@balance}$"
      return @balance
    end


  end # end of class SavingsAccount
end # end of Bank module

acc = Bank::SavingsAccount.new(299, 100)
acc.withdraw(88)
puts acc.balance
