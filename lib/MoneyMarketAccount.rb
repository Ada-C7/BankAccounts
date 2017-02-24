require_relative 'account_wave_2'

module Bank

  class MoneyMarketAccount < Account

    def initialize(id, starting_balance)
      @id = id
      @balance = starting_balance
      @transactions = 0
    end

    def withdraw(amount)
      super
      @transactions += 1
    end

    def deposit(amount)
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
