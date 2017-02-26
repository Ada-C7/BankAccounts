require 'csv'
require_relative 'account'

module Bank
  class CheckingAccount < Bank::Account
    attr_accessor :new_month
    attr_reader :num_checks_used

    def initialize(id, balance, open_date)
      super(id, balance, open_date)
      @num_checks_used = 0
      @new_month = false
    end

    # Method that handles withdraw
    def withdraw(withdraw_amount)
      # raise error for erroneous withdraw value
      raise ArgumentError.new ("Withdraw amount must be a positive numericla value") if ( !(withdraw_amount.class == Integer || withdraw_amount.class == Float) || withdraw_amount < 0 )

      # Error handling for insufficient funds for a withdraw
      transaction_fee = 100

      # Balance is insufficient
      if @balance  <= (withdraw_amount + transaction_fee)
        puts "The amount you enetered for the withdraw will cause the balance to go below the $0.00"
        # Ok to withdraw, updates the balance
      else
        @balance -= (withdraw_amount + transaction_fee)
      end
      return @balance
    end

    # Method that handles withdraw_using_check
    def withdraw_using_check(withdraw_amount)
      # raise error for non integer withdraw value
      raise ArgumentError.new ("Withdraw amount must be a positive numerical value") if ( !(withdraw_amount.class == Integer || withdraw_amount.class == Float) || withdraw_amount < 0 )

      # Error handling for insufficient funds for a withdraw
      transaction_fee = 100
      allotted_negative_balance = -1000
      check_fee = 0

      if @num_checks_used >= 3
        check_fee = 200
      end
      # Balance is insufficient
      if @balance < (withdraw_amount + transaction_fee + check_fee + allotted_negative_balance)
        puts "The amount you enetered for the withdraw will cause the balance to go over the allotted_negative_balance of -$10.00"
        # Ok to withdraw, update @balance
      else
        @balance -= (withdraw_amount + transaction_fee + check_fee)
        @num_checks_used += 1
      end
      return @balance
    end

    # Resets the number of checks used to zero
    def reset_checks()
      if @new_month
        @num_checks_used = 0
        @new_month = false
      end
    end

  end
end
