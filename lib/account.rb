module Bank
  class Account
    attr_reader :id, :balance, :open_date, :all_accounts
    # def initialize(id, balance)
    #   #error message not appearing in def withdraw
    #   #WOW, that balance can't be @balance. WHY?
    #   raise ArgumentError.new("balance must be >= 0") if balance < 0

    # end

    def initialize(id, balance)
      @id = id  #still need this
      @balance = balance #still need this

      @all_accounts = []
      CSV.read("accounts.csv").each do |line|
        @all_accounts[line.first] = line[1..-1]
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
      return @all_accounts
    end

    def self.id
      @all_accounts.each do |accounts|
        accounts.each_index do |i|
          return i if i == 0
        end
      end
    end

    def self.balance
      @all_accounts.each do |accounts|
        accounts.each_index do |i|
          return i if i == 1
        end
      end
    end

    def self.open_date
      @all_accounts.each do |accounts|
        accounts.each_index do |i|
          return i if i == 2
        end
      end
    end

    def self.find(id)
      #https://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-find
      @all_accounts.each do |account|
        if account.id == id
          return account
        end
      end
    end

##############WAVE 1##################

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
