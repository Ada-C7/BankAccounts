module Bank
  class Account

    attr_reader :balance, :id

    def initialize(id, balance) #deposit)
      if balance < 0
        raise ArgumentError.new "You can only open a new account with real money:)"
      else
        @balance = balance
        @id = id
      end
    end

    def new_account(balance)
      if @new_account >= 0
        @new_account  #Account.new(balance)
      else
        raise ArgumentError.new "You can only open a new account with real money:)"
      end
    end

    def withdraw(amount_to_withdraw)
      if amount_to_withdraw > @balance
        puts "Insufficient funds. Your balance is #{@balance}"
        raise ArgumentError.new("amount must be >= 0") if amount < 0
        # start_balance = @balance
        # @balance = start_balance
      else
        # start_balance = @balance
        @balance -= amount_to_withdraw
      end
      return @balance
    end

    def deposit(amount_to_deposit)
      if amount_to_deposit < 0
        raise ArgumentError.new "You must deposit real money."
      else
        @balance += amount_to_deposit
      end
    end
  end
end
