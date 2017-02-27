require_relative 'account'

module Bank
  class CheckingAccount < Account
    def initialize(id, balance)
      super(id, balance)
      @number_of_checks = 0 #free_checks = 3
    end

    def withdraw(amount)
      fee = 1.0
      balance_min = 0
      withdraw_internal(amount + fee, balance_min)
    end

    def withdraw_using_check(amount)
      if @number_of_checks >= 3
        fee = 2.0
      else
        fee = 0
      end
      balance_min = -10.0

      if update_balance?((amount + fee), balance_min)
        @number_of_checks += 1
      end

      withdraw_internal(amount + fee, balance_min)
    end

    def reset_checks
      @number_of_checks = 0
    end
  end
end
