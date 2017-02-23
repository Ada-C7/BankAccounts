require_relative 'account'

module Bank


  class SavingsAccount < Account


      def initialize(id, balance, open_date=nil)
        raise ArgumentError.new "The balance must be at least $10" if balance < 10
        super(id, balance)
      end
  end




end
