require_relative 'account_wave_2'

module Bank

  class MoneyMarketAccount < Account
    attr_reader :transactions, :balance, :id, :too_low

    def initialize(id, starting_balance)
      raise ArgumentError.new "starting must be >= 10000" if starting_balance < 10_000
      @id = id
      @balance = starting_balance
      @too_low = false
      @transactions = 0
      @withdraw_fee = 100
    end

    def withdraw(amount)
      if @too_low
        puts "You need to get your balance back up to 10k!"
        return
      else
        if @balance - amount < 10000
          @too_low = true
          @balance -= @withdraw_fee + amount
          puts "You need to get your balance back up to 10k!"
          @transactions += 1
        else
          @balance -= amount
          @transactions += 1
        end
      end
      # super
    end

    def deposit(amount)
      if @too_low && @balance + amount < 10000
        puts "You need to get your balance back up to 10k!"
        @balance = @balance
      end
      super
      @transactions += 1
    end

    def add_interest(rate)
      if rate < 0
        puts "rate must be positive"
        return
      else
        interest_amount = (@balance * (rate / 100)).to_f
        @balance += interest_amount
        return interest_amount
      end
    end

    def reset_transactions
      @transactions = 0
    end

  end

end
