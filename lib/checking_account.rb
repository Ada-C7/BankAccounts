module Bank

  class CheckingAccount < Bank::Account

    def initialize(id, balance, date)
      super(id, balance, date)
      @min_balance = -1000
      @fee = 100
    end
  end
end

def withdraw_math(amount)
  if @balance - amount - @fee > @min_balance
    puts "This withdral plus withdraw fee would bring you below required minimum balance of #{@min_balance}."
    raise ArgumentError.new "Insufficient funds. Your balance is #{@balance}"
  else
    @balance -= amount + @fee
  end
  return "Your balance after withdrawl is #{@balance}."
end

def withdraw(amount_to_withdraw)
  if amount_to_withdraw > @min_balance
    puts "Insufficient funds. Your balance is #{@balance}"
  elsif amount_to_withdraw < 0
    raise ArgumentError.new "Withdraw mount must be a positive number."
  else
    @balance -= amount_to_withdraw
  end
  return "Your balance after withdrawl is #{@balance}."
end
