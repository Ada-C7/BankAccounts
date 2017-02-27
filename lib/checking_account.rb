require_relative 'account'
module Bank
  class CheckingAccount < Bank::Account
    attr_reader :id, :balance

    def initialize(id, balance)
      @id = id
      @balance = balance
      @checks = 0
    end

    def withdraw(amount)

      new_balance = @balance - (amount+1)
      if new_balance < 0
        puts "Warning: insufficient fund."
        return @balance
      end
      @balance = new_balance
    end

    def withdraw_using_check(amount)
      raise ArgumentError.new "Please enter positive amount" if amount < 0
       @checks += 1
      if @checks > 3
        fee = 2
      else
        fee = 0
      end
      new_balance = @balance - (amount+fee)


      if new_balance < -10
        puts "Warning: insufficient fund."
        return @balance
      end
      @balance = new_balance
    end
    def reset_checks
      @checks = 0
    end
  end
end
