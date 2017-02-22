module Bank

  class Owner

    attr_accessor :name, :address, :email

    def initialize(user_info_hash)

      @name = user_info_hash[:name]
      @address = user_info_hash[:address]
      @email = user_info_hash[:email]
      
    end

  end

end
