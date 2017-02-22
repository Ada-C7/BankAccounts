
module Bank

  class Owner
    attr_reader :name, :address, :birthday, :favefood

    def initialize(owner_hash)
      @name = owner_hash[:name]
      @address = owner_hash[:address]
      @birthday = owner_hash[:birthday]
      @favefood = owner_hash[:favefood]
    end

  end

end
