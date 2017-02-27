require_relative 'account'

module Bank
  class MoneyMarket < Bank::Account
    attr_accessor :num_transaction
    def initialize(id, balance)
      super(id, balance)
      @num_transaction = 0
      raise ArgumentError.new("Balance cannot be less than $10,000") if @balance < 10000
    end

    def withdraw(amount)
      if @num_transaction < 6
        if (@balance - amount) < 10000
          @num_transaction += 1
          puts "Balance is lower than 10000.  Charged $100 fee"
          # puts @balance - (amount + 100)
          @balance = @balance - (amount + 100)
        else
          @num_transaction += 1
          @balance = (@balance - amount)
        end
      else
        puts "Maximum Number of Transactions has reached."
        return @balance
      end
    end

    def deposit(amount)
      if amount < 0
        raise ArgumentError.new "Minus amount deposited"
      else
        if @num_transaction < 6
          @balance = @balance + amount
          @num_transaction += 1
        else
          if @balance < 10000
            if (@balance + amount) > 10000
              @balance =  (@balance + amount)
              @num_transaction = @num_transaction
              puts "deposit balance< 10000 #{@num_transaction}"
            else
              puts "Maximum Number of Transactions has reached."
            end
          else
            puts "Maximum Number of Transactions has reached."
          end
        end
      end
    end

    def add_interest(rate)
      if rate < 0
        puts "Requires a positive rate"
      else
        interest = @balance * rate
        @balance = @balance + (@balance * rate)
        return interest
      end
    end

    def reset_transactions
      @num_transaction = 0
    end



  end
end


a = Bank::MoneyMarket.new(1, 10000)
a.deposit(30)
puts a.balance
a.deposit(30)
puts a.balance
a.deposit(30)
puts a.balance
a.withdraw(50)
puts a.balance
a.withdraw(50)
puts a.balance
a.withdraw(50)
puts a.balance
a.deposit(500)
puts a.balance
a.deposit(500)
puts a.balance
puts a.num_transaction
