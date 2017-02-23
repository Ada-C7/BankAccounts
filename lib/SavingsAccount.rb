require_relative 'account'

module Bank

  class SavingsAccount < Account

    def initialize(id, initial_deposit)
      raise ArgumentError if initial_deposit < 10
      @initial_deposit = initial_deposit
      @balance = @initial_deposit
      @id = id
    end

    def withdraw(amount)
      super
      
    end

    def add_interest
    end


  end

end
