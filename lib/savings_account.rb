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
