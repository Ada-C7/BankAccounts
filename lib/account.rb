# Create a class inside of a module
# Create methods inside the class to perform actions
# Learn how Ruby does error handling
# Verify code correctness by testing
require 'csv'
require 'awesome_print'


module Bank
  class Account
    attr_accessor :id, :balance

    def self.all
      data_array = CSV.read("../support/accounts.csv")
      account_array = []
      data_array.each do |account|
        account_array << (Account.new(account[0], account[1].to_i))
      end
      return account_array
    end

  # self.find(id) - returns an instance of Account
  # where the value of the id field in the CSV matches
  # the passed parameter.

    def self.find(id)
      

      return
    end


    def initialize(id, balance)
      @id = id
      raise ArgumentError.new("balance must be greater than zero") if balance < 0
      if balance >= 0
        @balance = balance
      end
    end

    def withdraw(withdrawal_amount)

      raise ArgumentError.new "You cannot withdraw a negative amount" if withdrawal_amount < 0


      if @balance >= withdrawal_amount
        @balance -= withdrawal_amount
      else
        puts "Cannot withdraw more than is in the account"
      end
      return @balance
    end

    def deposit(deposit_amount)
        raise ArgumentError.new "You must deposit an amount" if deposit_amount < 0
        @balance += deposit_amount
    end


  end #end class Account


#   class Owner
#     attr_accessor :name, :address, :dob
#
#      def initialize(name, dob, address)
#        @name = name
#        @dob = dob
#        @address = address
#       #    street1: "1221 N. Fife",
#       #    street2: "#4",
#       #    city: "Tacoma",
#       #    state: "WA",
#       #    zip: "98406"
#       #  }
#
#      end
# #
#        def enter_address(street1, street2, city, state, zip)
#          address = {
#            street1: "1221 N. Fife",
#            street2: "#4",
#            city: "Tacoma",
#            state: "WA",
#            zip: "98406"
#          }
#        end
# #
#   end #end owner class
end #end module Bank

# accounts = Account.all
# puts accounts
