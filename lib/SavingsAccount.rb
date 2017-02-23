require_relative '../lib/account_wave_2'

module Bank

  class SavingsAccount < Account

    attr_reader :initial_balance, :balance, :id

    def initialize(id, initial_balance)
      raise ArgumentError.new "initial balance must be at least 10" if initial_balance < 10
      @initial_balance = initial_balance
      @balance = @initial_balance
      @id = id
    end

    def withdraw(amount)
      fee = 2
      if @balance - (amount) < 10 || @balance - (amount + fee) < 10
        puts "balance can't go < 10"
      else
        super
        @balance -= fee
      end
      # @balance -= amount
    end

    def add_interest
    end


  end

end
#
