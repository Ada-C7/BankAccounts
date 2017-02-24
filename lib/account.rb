require 'CSV'
module Bank
  class Account
    attr_reader :id, :balance, :date

    def initialize(id, balance, date)
      raise ArgumentError.new("balance must be >= 0") if balance < 0
      @id = id.to_i
      @balance = balance.to_i
      @date = date
    end

    def withdraw(amount, fee = 0, min_balance = 0)
      raise ArgumentError.new ("Nice try! You can't withdraw negative money, and withdrawing $0 would be a waste of our time.") if amount <= 0

      balance_would_be = @balance - amount - fee

      if balance_would_be < min_balance
        puts "You don't have enough money to withdraw #{amount} cents."

        puts "There would be a #{fee} convenience fees."

        puts "You must maintain a minimum balance of #{min_balance} cents."
      else
        @balance = balance_would_be
      end
      return @balance
    end

    def deposit(amount)
      raise ArgumentError.new ("We don't want your debt (negative money)  here!") if amount < 0

      @balance += amount
      return @balance
    end

    # returns a collection of Account instances, representing all of the Accounts described in CSV
    def self.all(csv_filename)
      CSV.read(csv_filename).map do |row|
        id = row[0].to_i
        balance = row[1].to_i
        date = row[2]
        self.new(id, balance, date)
      end
      #return accounts
    end

    def self.find(csv_filename, id_to_find)
      fail = proc {
        raise ArgumentError.new("There is no client with the id you entered.")
      }
      self.all(csv_filename).find(fail) do |acct|
        acct.id.to_i == id_to_find.to_i
      end
    end
  end
end
