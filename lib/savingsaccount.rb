module Bank
  class SavingsAccount < Account

    def initialize(account_info)
      super
      raise ArgumentError.new("Minimum balance is $10.") if @balance < 10
    end

    def withdraw(amount)
      if amount + 12 > @balance
        puts "Insufficient funds."
        @balance
      else
        super
        @balance -= 2
      end
    end

    def add_interest(rate)
      raise ArgumentError.new("Interest rate must be positive.") if rate < 0
      interest = @balance * rate/100
      @balance += interest

      interest
    end

  end
end
