require "byebug"

class ComputerPlayer

  attr_accessor :memory_board, :guess_hash, :last_guess

  def initialize
    @memory_board = Array.new(5) { Array.new(4,:unknown) }
    @guess_hash = Hash.new() { |hash, key| hash[key] = [] }
    @last_guess = nil
  end

  def [](pos)
    row, col = pos
    @memory_board[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @memory_board[row][col] = val
  end

  def generate_guess
    pos1 = first_guess
    pos2 = second_guess(pos1)
    self.last_guess = [pos1, pos2]
    self.last_guess
  end

  def first_guess
    # debugger
    @guess_hash.each do |_, val|
      return val[0] unless val.length > 1
    end
    random_guess
  end

  def second_guess(first_position)
    unless self[first_position] == :unknown
      key_value = self[first_position]
      positions = self.guess_hash[key_value]
      return positions[1]
    end

    second_guess = first_guess
    second_guess = random_guess until first_guess != second_guess
    second_guess
  end

  def random_guess
    random_pos = [rand(5), rand(4)]
    random_pos = [rand(5), rand(4)] until self[random_pos] == :unknown
    return random_pos
  end

  def receive_info(face_values)
    first_value, second_value = face_values
    if first_value == second_value
      guess_hash.delete(first_value)
      self.board[last_guess[0]] = :found
      self.board[last_guess[1]] = :found
    else
      self.guess_hash[first_value] << last_guess[0]
      self.guess_hash[second_value] << last_guess[1]
    end
  end


end
