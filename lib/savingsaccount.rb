require_relative 'account.rb'
module Bank
  class SavingsAccount < Account
    def initialize(id = "", balance = 10, date_opened = "" )
      super(id, balance, date_opened)

        raise ArgumentError.new("balance must be >= 10") if balance < 10


    end

    def withdraw(amount)
      total_withdrawl = amount + 2
        super(total_withdrawl, 10)
      #end
      return @balance
    end


    def add_interest(rate)

      if rate > 0 then @balance = balance * (1 + (rate/100))
      else puts "Rate must be greater than 0"
      end
      return @balance
    end
  end
end
