module Bank
  class CheckingAccount < Account
    def initialize(id, initial_balance, open_date = 0, owner_id = -1)
      super
    end

    def withdraw(amount)
      withdrawal_fee = 1.0
      if (@balance - amount - withdrawal_fee) > 0
        @balance -= (amount + withdrawal_fee)
      else
        puts "Insufficient funds, balance would go negative."
      end

      return @balance
    end

  end

end
