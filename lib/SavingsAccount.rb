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
    end

    def withdraw_using_check(amount)
    end

    def reset_checks
    end

    


  end

end
