require 'csv'
require_relative 'account'

module Bank
  class SavingsAccount < Bank::Account

    def initialize(id, balance, open_date)
      raise ArgumentError.new("Your initial balance must be at least $10.00") if balance < 1000
      super(id, balance, open_date)
    end

    # Method that handles withdraw
    def withdraw(withdraw_amount)
      # Raise error for non integer withdraw value
      raise ArgumentError.new ("Withdraw amount must be a positive numericla value") if ( !(withdraw_amount.class == Integer || withdraw_amount.class == Float) || withdraw_amount < 0 )
      # Raises error for negativd withdraw value
      raise ArgumentError.new("Withdraw amount cannot be a negetive value") if withdraw_amount < 0

      # Error handling for insufficient funds for a withdraw
      transaction_fee = 200
      minimum_balance = 1000

      # Balance is insufficient
      if @balance  <= (withdraw_amount + minimum_balance + transaction_fee)
        puts "The amount you enetered for the withdraw will cause your balance to go below the $10.00 minimum balance required"
      # Allows withdraw, update @balance
      else
        @balance -= (withdraw_amount + transaction_fee)
      end
      return @balance
    end

    # Method that handles interest
    def add_interest(rate)
      raise ArgumentError.new("The interest rate must be a positive numerical value") if rate <= 0
      interest = @balance * rate
      @balance += interest
      return interest
    end
  end
end
