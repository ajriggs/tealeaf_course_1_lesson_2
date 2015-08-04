module ComputerAi
  def square_to_win(line, computer_marker)
    if (line.values.count(computer_marker) == 2)
      line.select{|_, value| value == ' '}.keys.first
    else
      false
    end
  end

  def square_to_block(line, human_marker)
    if (line.values.count(human_marker) == 2)
      line.select{|_, value| value == ' '}.keys.first
    else
      false
    end
  end
end

class Board
  attr_accessor :contents

  WINNING_LINES = [[1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 2, 3], [4, 5, 6],
  [7, 8, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    self.contents = (1..9).each_with_object({}) do |position, hash|
      hash[position] = ' '
    end
  end

  def empty_squares
    contents.select {|_, value| value == ' ' }.keys
  end

  def line_contents
    line_contents = WINNING_LINES.each_with_object([]) do |line, array|
      array << {line[0] => self.contents[line[0]],
      line[1] => self.contents[line[1]], line[2] => self.contents[line[2]]}
    end
    line_contents
  end

  def render
    s = contents.values
    system 'clear'
    puts "     |     |     "
    puts "  #{s[0]}  |  #{s[1]}  |  #{s[2]}  "
    puts "_____|_____|_____"
    puts "     |     |     "
    puts "  #{s[3]}  |  #{s[4]}  |  #{s[5]}  "
    puts "_____|_____|_____"
    puts "     |     |     "
    puts "  #{s[6]}  |  #{s[7]}  |  #{s[8]}  "
    puts "     |     |     "
  end
end

class Game
  include ComputerAi

  attr_accessor :human_marker, :computer_marker, :board

  def initialize
    self.human_marker = 'X'
    self.computer_marker = 'O'
  end

  def say(msg)
    puts  "=> #{msg}".ljust(62)
  end

  def human_marks_square
    say("Choose from the availble squares: #{board.empty_squares}")
    chosen_square = gets.chomp.to_i
    loop do
      break if board.empty_squares.include?(chosen_square)
      say("Invalid. Choose from the available squares: #{board.empty_squares}")
      chosen_square = gets.chomp.to_i
    end
    board.contents[chosen_square] = human_marker
  end

  def computer_marks_square
    chose = false
    board.line_contents.each do |position, _|
      win_position = square_to_win(position, computer_marker)
      block_position = square_to_block(position, human_marker)
      if win_position
        board.contents[win_position] = computer_marker
        chose = true
        break
      elsif block_position
        board.contents[block_position] = computer_marker
        chose = true
        break
      end
    end
    unless chose == true
      if board.contents[5] == ' '
        board.contents[5] = computer_marker
      else
        board.contents[board.empty_squares.sample] = computer_marker
      end
    end
  end

  def winner
    board.line_contents.each do |line|
      return 'You' if line.values.count(human_marker) == 3
      return 'The computer' if line.values.count(computer_marker) == 3
    end
    false
  end

  def game_over?
    winner || board.empty_squares.empty?
  end

  def announce_result
    winner ? say("#{winner} won!") : say("It's a tie!")
  end

  def run
    self.board = Board.new
    board.render
    loop do
      human_marks_square
      board.render
      if game_over?
        announce_result
        break
      end
      computer_marks_square
      board.render
      if game_over?
        announce_result
        break
      end
    end
    say("Play again? [Y/N]")
  end

  def play_again?(response)
    loop do
      break if response.downcase == 'y' || response.downcase == 'n'
      say("Invalid response. Play again? [Y/N]")
      response = gets.chomp
    end
    response.downcase == 'y'
  end

  def bye
    say('Thanks for playing!')
  end

end

game = Game.new
loop do
  game.run
  break unless game.play_again?(gets.chomp)
end
game.bye
