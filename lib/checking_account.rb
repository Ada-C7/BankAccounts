module Bank
  class CheckingAccount < Account
    attr_accessor :counter
    def initialize(id, balance, date = nil )
      super(id, balance, date)
      @counter = 0 # Keeps track of number of check transactions
    end

    def withdraw(amount)
      super(amount)

      # Applies $1 transaction fee
      # Confirms that update balance (with transaction fee) is greater than 0
      if (@balance - 1) < 0
        puts "balance must be >= 0"
        return @balance += amount
      else
        return @balance -= 1
      end
    end

    def withdraw_using_check(amount)
      # Verifies that withdrawal amount is positive
      raise ArgumentError.new("withdrawl amount must be >= 0") if amount < 0

      # subtracts withdrawal amount from balance
      @balance -= amount

      # checks if 3 free checks have been used
      # checks if balance (after withdrawal) would be greater than -$10
      # returns balance and increases counter, if so
      # returns original balance, if not
      if @counter <= 3
        if @balance >= -10
          @counter += 1
          return @balance
        else
          puts "Sorry, balance cannot go below -10"
          return @balance += amount
        end
      # if three free checks have already been used, subtracts $2 fee
      # Verifies that balance (after fee and withdrawal) would be greater than -$10
      elsif @counter > 3
        @balance -= 2
        if @balance >= -10
          @counter += 1
          return @balance
        else
          puts "Sorry, balance cannot go below -10"
          @balance = @balance + amount + 2
          return @balance
        end
      end
    end

    # resets free checks counter to 0
    def reset_checks
      @counter = 0
    end

  end
end
