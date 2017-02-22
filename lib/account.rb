require_relative 'owner'
module Bank

  class Account
    # you are not using writer methods when you change @balance so can get away with an attr_reader
    attr_reader :id, :balance

    #the owner is going to be the owner object
    # def initialize(id, balance, owner)
    def initialize(id, balance)
      @id = id
      unless balance >= 0
        raise ArgumentError.new "Balance must be greater or equal to 0"
      end
      @balance = balance
    end

    def withdraw(withdrawal_amount)
      check_amount_is_over_zero(withdrawal_amount)
      if @balance - withdrawal_amount >= 0
        @balance = @balance - withdrawal_amount
      else
        # figoure out how to send this to a printer class...
        puts "Insufficient funds"
      end
      @balance
    end

    def deposit(deposit_amount)
      check_amount_is_over_zero(deposit_amount)
      @balance = @balance + deposit_amount
    end

    def check_amount_is_over_zero(amount)
      unless amount >= 0
        raise ArgumentError.new "Amount must be greater than zero"
      end
    end
  end

end
