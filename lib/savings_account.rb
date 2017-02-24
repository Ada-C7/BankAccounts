require File.expand_path('../account.rb', __FILE__)

class SavingsAccount < Bank::Account
  #attr_accessor
  def initialize(id, balance, openDate = '1999-03-27 11:30:09 -0800')
    super(id, balance, openDate = '1999-03-27 11:30:09 -0800')
    #@interest_rate
    raise ArgumentError.new("initial balance must be > 10") if @balance < 10
    #@balance > 10
  end

  def withdraw(amount)
    super(amount)
    @balance -= 2
    if @balance < 10
      print "Your balance has to be more than 10"
      @balance += amount + 2
    end
    return @balance
  end

  def add_interest(rate)
    if rate < 0
      print "The rate has to be positive" #no puts 
    else
      interest = @balance * (rate/100.0)
      @balance += interest
      return interest #float
    end
  end
end

#savingsaccount = SavingsAccount.new(1212, 1)
