require_relative 'account'

module Bank
class SavingsAccount < Account
  attr_accessor :interest_rate

  def initialize( id, balance, interest_rate = 0.25)
    raise ArgumentError.new "Balance must be more than 10" unless balance > 1000
    if balance > 1000
      super(id, balance)

      @interest_rate = interest_rate
    end
  end #this is for initialize

  def withdraw(amount)
    raise ArgumentError.new if amount < 0

    #check that balance after will exceed 10 + $2 fee
    if @balance - amount - 200 < 1000
      puts "Sorry, minimum $10 balance."
    else
      @balance = @balance - amount - 200
    end
    @balance
  end #withdraw end

  #add interst to savings
  def add_interest(rate = @interest_rate)

    total_interst = @balance * rate/100
    @balance += total_interst
    return total_interst

  end #This is for add_interest

end # This is for the class
end
