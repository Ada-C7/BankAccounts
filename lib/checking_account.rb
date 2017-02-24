require 'csv'
require_relative 'account'

# CheckingAccount class to inherit behavior from the Account class
class Bank
  class CheckingAccount < Bank::Account


    def withdraw_using_check(amount)
    end

    def rest_checks
    end

  end
end
