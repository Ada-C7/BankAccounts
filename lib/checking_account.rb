require_relative 'account'

module Bank


  class CheckingAccount < Account
    attr_accessor :checks

      def initialize(id, balance)
        super(id, balance)
        @checks = 3
      end
  end




end
