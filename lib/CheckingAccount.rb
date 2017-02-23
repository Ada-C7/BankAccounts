require_relative 'account'

module Bank

  class CheckingAccount < Account

    def initialize
    end

    def withdraw(amount)
      super
      
    end

    def withdraw_using_check(amount)
    end

    def reset_checks
    end

  end

end
