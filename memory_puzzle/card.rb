class Card
  attr_reader :face_value
  attr_accessor :face_down

  def initialize(face_value)
    @face_value = face_value
    @face_down = true
  end

  def hide
    @face_down = true
  end

  def reveal
    @face_value
  end

end
