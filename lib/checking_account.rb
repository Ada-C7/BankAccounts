require 'csv'
require_relative '../lib/account'

module Bank
  class CheckingAccount < Bank::Account
    def withdraw_using_check(amount)
    end

    def reset_checks
    end
  end
end
