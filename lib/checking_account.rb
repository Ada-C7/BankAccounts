require_relative 'account'
module Bank
  class CheckingAccount < Bank::Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id
      @balance = balance
    end

    def withdraw(amount)
      new_balance = @balance - (amount+1)
      if new_balance < 0
        puts "Warning: insufficient fund."
        return @balance
      end
      @balance = new_balance
    end

  end
end
