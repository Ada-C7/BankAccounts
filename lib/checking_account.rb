require 'csv'
require_relative '../lib/account'

module Bank

class CheckingAccount < Account

def withdraw(withdrawal_amount)
check_balance = @balance - (withdrawal_amount + 1)
  if check_balance < 0
    puts "Warning, this will be below 0 , " + (@balance.to_s)
    # return @balance
  else
    super + (-1)
  end
end

def withdraw_with_check(amount)

end



# checking_account = CheckingAccount.new(11, 200)
#
# puts checking_account.withdraw(10)
end
end
