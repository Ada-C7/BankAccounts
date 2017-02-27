# die.rb
module Bank

  class Die
  def initialize
  end

  def roll
    return rand(1..6)
  end

end
end

die = Die.new
puts die
