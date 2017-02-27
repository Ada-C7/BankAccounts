require_relative 'account.rb'

module Bank
  class SavingsAccount < Account
    def initialize id, balance, opendate = "1999-03-27 11:30:09 -0800"
      # check_initial_balance
      if balance <= 10
        raise ArgumentError.new "Initial balance must be at least $10."
      end

      #initial balance meets threshold, follow account rules to initialize
      super
    end


    def withdraw amount  #hoW can I use super?
      if @balance - amount - 2 < 10
        puts "Insufficient Funds (balance will go below $10)"
        return @balance
      else
        amount += 2
        super
      end
    end

    def add_interest rate
      if rate <= 0
        raise ArgumentError.new "Interest rate must be more than 0"
      end
      interest = @balance * rate / 100
      @balance += interest
      return interest
    end
    
  end
end
