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
      super

    end

    def add_interest
    end


  end

end
#
