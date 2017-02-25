require 'csv'

module Bank

  class Owner
    attr_reader :id, :last_name, :first_name, :st_address, :city, :state

    def initialize(owner_hash)
      @id = owner_hash[:id]
      @last_name = owner_hash[:last_name]
      @first_name = owner_hash[:first_name]
      @st_address = owner_hash[:st_address]
      @city = owner_hash[:city]
      @state = owner_hash[:state]
    end

    def self.all
      # pro tip from Jeremy! memoization: first time, @all_owners is nil, so it reads the CSV, but next time, it just returns @all_owners
      return @all_owners if @all_owners
      @all_owners = []
      CSV.open("/Users/brenna/ada/week3/BankAccounts/support/account_owners.csv").each do | line |
        owner_hash = {
          id:         line[0].to_i,
          last_name:  line[1],
          first_name: line[2],
          st_address: line[3],
          city:       line[4],
          state:      line[5]
        }
        @all_owners << Bank::Owner.new(owner_hash)
      end
      
      @all_owners
    end

    def self.find(id)
      self.all.each do |owner|
        if owner.id == id
          return owner
        end
      end

      raise ArgumentError.new("There's no such owner ID.")
    end

  end

end
