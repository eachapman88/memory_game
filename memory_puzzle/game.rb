require_relative "board"
require_relative "player"
require_relative "computerplayer"

class Game

  attr_accessor :board, :player

  def initialize(board = Board.new, player)
    @board = board
    @board.populate
    @player = player
  end

  def run
    until over?
      play_round
      system("clear")
      @board.render
    end
  end


  def over?
    @board.won?
  end


  def play_round
    pos1, pos2 = self.player.generate_guess

    if pos1 == pos2
      puts "You blew it try again. Enter different positions dummy"
      return
    end

    if @board[pos1].face_value == @board[pos2].face_value
      self.player.receive_info(@board[pos1].face_value)
      @board[pos1].face_down = false
      @board[pos2].face_down = false
    end
    player.receive_info(@board[pos1].face_value)

  end

  def valid_guess?(pos)
    row, col = pos
    return false unless (0...@board.grid.length).include?(row)
    return false unless (0...@board.grid[0].length).include?(col)
    @board[pos].face_down
  end

end

if __FILE__ == $PROGRAM_NAME
  player = ComputerPlayer.new
  game = Game.new(player)
  game.run
end
