require 'csv'

module Bank

  class Owner
    attr_reader :id, :last_name, :first_name, :st_address, :city, :state #, :name, :address, :birthday, :favefood

    def initialize(owner_hash)
      # @name = owner_hash[:name]
      # @address = owner_hash[:address]
      # @birthday = owner_hash[:birthday]
      # @favefood = owner_hash[:favefood]
      @id = owner_hash[:id]
      @last_name = owner_hash[:last_name]
      @first_name = owner_hash[:first_name]
      @st_address = owner_hash[:st_address]
      @city = owner_hash[:city]
      @state = owner_hash[:state]
    end

    def self.all
      CSV.open("/Users/brenna/ada/week3/BankAccounts/support/account_owners.csv").each do | line |
        owner_hash = {
          id:         line[0].to_i,
          last_name:  line[1],
          first_name: line[2],
          st_address: line[3],
          city:       line[4],
          state:      line[5]
        }
        ALL_OWNERS << Bank::Owner.new(owner_hash)
      end
      ALL_OWNERS
    end

    def self.find(id)
      # accounts = Bank::Account.all
      # raise ArgumentError.new("There's no such account ID, you nincompoop.") if ![1212, 1213, 1214, 1215, 1216, 1217, 15151, 15152, 15153, 15154, 15155, 15156].include?(id)
      # accounts.each_with_index do |acct, index|
      #     if acct.id == id
      #       return accounts[index]
      #     end
      # end
    end

  end

end
