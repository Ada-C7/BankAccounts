require_relative 'account'

module Bank

  class MoneyMarketAccount < Bank::Account

    def set_balance(start_balance)
      # IF the initial balance is < 10,000
      #raise an argument error.
      if start_balance < 10000
        raise ArgumentError.new "You cannot initialize a new Money Market account with less than 10k."
      else
        start_balance
      end

    end

  end

end
