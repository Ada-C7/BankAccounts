module Bank
  class Owner
    attr_reader :last_name, :first_name

    def initialize(last_name, first_name)
      @last_name = last_name
      @first_name = first_name
    end

  end
end
