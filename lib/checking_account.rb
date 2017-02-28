module Bank

  class CheckingAccount < Bank::Account

    def initialize(id, balance, date)
      super(id, balance, date)
      @@min_balance = 0
      @@check_min_balance = -1000
      @fee = 100
    end
  end
end

def withdraw_math(amount)
  if @balance - amount - @fee > @@min_balance
    puts "This withdral plus withdraw fee would bring you below required minimum balance of #{@@min_balance}."
    raise ArgumentError.new "Insufficient funds. Your balance is #{@balance}"
  else
    @balance -= amount + @fee
  end
  return "Your balance after withdrawl is #{@balance}."
end

def withdraw(amount_to_withdraw)
  if amount_to_withdraw > @balance
    raise ArgumentError.new "Insufficient funds. Your balance is #{@balance}"
  elsif amount_to_withdraw < 0
    raise ArgumentError.new "Withdraw amount must be a positive number."
  else
    @balance -= amount_to_withdraw
    return "Your balance after withdrawl is #{@balance}."
  end
end

def check_withdraw
  if amount_to_withdraw > @balance - 10
    raise ArgumentError.new "We can't honor your check. Your balance is #{@balance}"
  elsif
    amount_to_withdraw > @balance && >= @balance + -10
    puts "This check with overdraft your account. Are you sure you want to write it?"
  end


  def self.withdraw_using_check(number)
    checks_written = []
    while checks_written is =< 3
    elsif
      checks_written >= 3
      checks == @balance - 200
      #for each loop here
      #checks_written.each do |fee|
        #i += 1
        @balance -= 2.00
      end
      reset_checks = checks_written(0)
    end
