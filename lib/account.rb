module Bank
  class Account
    def initialize ID, initial_balance
      @id = ID
      if initial_balance >0
        @initial_balance
      else
        raise ArgumentError.new "Initial balance must be more than zero."
      @balance = @initial_balance

  end

  def withdraw(new_withdrawal)
    
  end

  def deposit(new_deposit)

  end

end
