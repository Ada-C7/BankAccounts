
module Bank

  class CheckingAccount < Account

    def withdraw(withdrawal_amount)
      super
      @balance -= 1 unless withdrawal_amount > @balance
        return @balance
    end

  end

end
