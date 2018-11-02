require_relative "card.rb"
require "byebug"

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(5) { Array.new(4) }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, card)
    row, col = pos
    @grid[row][col] = card
  end

  def populate
    cards = generate_cards
    @grid.each_with_index do |row, y_axis|
      row.each_with_index do |_, x_axis|
        pos = [y_axis, x_axis]
        self[pos] = cards.pop
      end
    end
  end

  def generate_cards
    cards = []
    (10).times do |new_card|
      cards << Card.new(new_card)
    end
    cards += cards
    cards.shuffle
  end

  def render
    display = Array.new(5) { Array.new(4) }
    display.each_with_index do |row, y_axis|
      row.each_with_index do |el, x_axis|
        pos = [y_axis, x_axis]
        if self[pos].face_down
          display[y_axis][x_axis] = " "
        else
          display[y_axis][x_axis] = self[pos].face_value.to_s
        end
      end
    end
    p display
  end

  def won?
    grid.flatten.none? { |card| card.face_down }
  end

  def reveal(pos)
    @grid[pos].reveal
  end

end
