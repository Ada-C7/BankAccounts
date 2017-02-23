require_relative 'account'

module Bank


  class SavingsAccount < Account
    

      def initialize(id, balance, open_date=nil)
        super(id, balance)
      end
  end




end
