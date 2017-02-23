module Bank
  class Account
    attr_reader :id, :balance, :open_date, @accounts
    # def initialize(id, balance)
    #   #error message not appearing in def withdraw
    #   #WOW, that balance can't be @balance. WHY?
    #   raise ArgumentError.new("balance must be >= 0") if balance < 0
    #
    #   @id = id
    #   @balance = balance
    # end

    def initialize
      @accounts = []
      CSV.read("accounts.csv").each do |line|
        @accounts[line.first] = line[1..-1]
      end

      #make these seperate methods instead? - OH! That's why
      #we have self.find(id)!
      # @id = []
      # @balance = []
      # @open_date = []
      # CSV.read("accounts.csv").each do |account|
      #   account.each do |index|
          # @id << account[index]
          # @balance << account[index]
          # @open_date << account[index]
          # index += 1
      #   end
      # end
    end

    def self.all
      return @accounts
    end

    def self.find(id)
      #https://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-find
      @accounts.each do |outside_array|
        outside_array.each_index do |i|
          return i if i == 0
        end
      end
    end

    def withdraw(amount)
      start_balance = @balance
      withdrawal_amount = amount
      if withdrawal_amount < 0
        raise ArgumentError.new 'You cannot withdraw a negative number'
      end
      if withdrawal_amount > start_balance
        puts 'Warning, account would go negative. Cannot withdraw.'
        withdrawal_amount = 0
      end
      @balance = start_balance - withdrawal_amount
    end

    def deposit(amount)
      start_balance = @balance
      deposit_amount = amount
      if deposit_amount < 0
        raise ArgumentError.new 'You cannot deposit a negative number'
      end
      @balance = start_balance + deposit_amount
    end
  end
end
