require 'csv'
require_relative 'account'

module Bank
  class MoneyMarketAccount < Bank::Account
    attr_accessor :new_month
    attr_reader :num_transaction
    def initialize(id, balance, open_date)
      raise ArgumentError.new("Your initial balance must be at least $10,000.00") if balance < 1000000
      super(id, balance, open_date)
      @num_transaction = 0
      @new_month = false
    end

    def withdraw(withdraw_amount)
      # Raise error for non integer withdraw value
      raise ArgumentError.new ("Withdraw amount must be a positive numerical value") if ( !(withdraw_amount.class == Integer || withdraw_amount.class == Float) || withdraw_amount < 0 )
      minimum_balance = 1000000
      penalty_fee = 0

      # Withdraw allowed only if num_transaction is less than 6 AND balance is above minimum_balance
      if @num_transaction < 6 && @balance >= minimum_balance
        # Withdraw_amount will cause balance to go below minimum_balance
        if @balance < withdraw_amount + minimum_balance
          penalty_fee = 10000
        end
        @balance -= (withdraw_amount + penalty_fee)
        @num_transaction += 1
      end
      return @balance
    end

    # Resets the number of checks used to zero
    def reset_transactions()
      if @new_month
        if @num_transaction == 0
          puts "You haven't made any transactions yet."
        else
          @num_transaction = 0
        end
        @new_month = false
      end
    end











  end
end
