require_relative 'account'
module Bank
  class SavingsAccount < Bank::Account
    def initialize(id, balance, open_date)
      raise ArgumentError.new("Your initial balance must be at least $10.00") if balance < 1000
      super(id, balance, open_date)
    end
  end
end
