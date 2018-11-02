class Player

attr_reader :name

  def initialize(name="Bonzo")
    @name = name
  end

  def prompt
    puts "Please enter first coordinate (y axis): "
    y_axis = get_input
    puts "Please enter second coordinate (x axis): "
    x_axis = get_input
    [y_axis, x_axis]
  end

private

  def get_input
    gets.chomp.to_i
  end

end
