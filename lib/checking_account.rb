require_relative '../lib/account'
require 'csv'
require 'date'
module Bank
  class CheckingAccount < Account
    attr_accessor :check_uses
    def initialize(id, balance)
      super(id, balance)
      raise ArgumentError.new("balance must be >= 10$") if balance < 10
      @check_uses = 0
    end
    # Inherits functionality from super class
    def withdraw(amount)
      fee = 1
      super(amount, fee)
    end
    # Method calls Account#withdraw_internal method
    # and also takes vare about number of checks was used this month
    def withdraw_using_check(amount)
      # fee will be 0 while number of checks is <= 3
      fee = 0
      fee = 2 if @check_uses >= 3
      minimum_balance = -10
      result = withdraw_internal(amount, fee, minimum_balance)
      @check_uses += 1
      return result
    end

    def reset_checks
      @check_uses = 0
    end
  end # end of class CheckingAccount
end # end of Bank module
