require_relative 'account'

module Bank
  class SavingsAccount < Account
    def initialize(id, balance, open_date = '2012 - 12-21 12:21:12 -0800')
      super(id, balance, open_date)
      raise ArgumentError, "You cannot have a negative balance" unless balance > 10
    end

    def withdraw(amount)
      new_balance = @balance - amount
      if new_balance < 12
        puts "You don't have enough money in your account"
      else
        super(amount)
        return @balance -=2
      end
    end

    def add_interest(rate)
      raise ArgumentError, "You cannot have a negative rate" unless rate >= 0
      interest = rate/100 * @balance
      @balance = @balance + interest
      return interest
    end

  end
end
#SEED 5866
# account = Bank::SavingsAccount.new(12345, 100)
# account.withdraw(95)
