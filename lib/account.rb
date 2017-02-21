module Bank

     class Account

          attr_accessor :id, :balance

          def initialize(id, balance)

               @id = id

               if balance > -1
                    @balance = balance

               else
                    raise ArgumentError.new "Can't create an account with a negative balance."

               end

          end
     end

end
