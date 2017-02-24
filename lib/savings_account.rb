require_relative 'account.rb'
module Bank
class SavingsAccount < Bank::Account
  def initialize id, balance, opendate = "1999-03-27 11:30:09 -0800"
    # check_initial_balance
    if balance >= 10
      @balance = balance
    else
      raise ArgumentError.new "Initial balance must be at least $10."
    end
    #initial balance meets threshold, follow account rules to initialize
    super
  end


  def withdraw amount
    #new balance can't go below 10
    #adds a transaction fee
  end

  def add_interest rate
    # balance*rate/100
    # return interest that was added (do not return updated balance)
  end


end
end
