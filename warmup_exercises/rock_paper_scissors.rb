class Player
  include Comparable

  attr_reader :name, :choice

  def initialize(player_type)
    if player_type == 'human'
      name = gets.chomp
      loop do
        break unless name == '' || name =~ /^\s+$/
        Request.new.valid_input_please
        Request.new.player_name
        name = gets.chomp
      end
      @name = name.capitalize
    elsif player_type == 'computer'
      @name = 'The computer'
    end
  end

  def choice=(choice)
    loop do
      break if (choice.upcase == 'ROCK') || (choice.upcase == 'PAPER') ||
      (choice.upcase == 'SCISSORS')
      Request.new.valid_input_please
      Request.new.player_choice
      choice = gets.chomp
    end
    @choice = choice.upcase
  end

  def <=>(other_player)
    if self.choice == other_player.choice
      0
    elsif (self.choice == 'ROCK' && other_player.choice == 'SCISSORS') ||
    (self.choice == 'PAPER' && other_player.choice == 'ROCK') ||
    (self.choice == 'SCISSORS' && other_player.choice == 'PAPER')
      1
    else
      -1
    end
  end
end

module CoreUi
  def title(title)
    puts title.center(62, '~')
  end

  def say(msg)
    puts  "=> #{msg}".ljust(62)
  end
end

class GameText
  include CoreUi

  attr_reader :player, :computer

  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def greet_player
    say("Hi #{player.name}! Let's play!")
    sleep 1
  end

  def announce_new_game
    system 'clear'
    title("Let's Play Rock-Paper-Scissors!")
  end

  def announce_choices
    system 'clear'
    title("Results")
    say("#{player.name} chose #{player.choice}.")
    say("The computer chose #{computer.choice}.")
  end

  def announce_winner(winner)
    say("#{winner} wins!") if winner
    say("It's a tie!") if !winner
  end

  def bye
    say('Bye, and thanks for playing!')
  end

end

class Request
  include CoreUi

  def player_name
    system 'clear'
    title("What's your name?")
    say("Please enter a name or alias:")
  end

  def player_choice
    say("Which do you choose? [ROCK, PAPER, or SCISSORS]")
  end

  def valid_input_please
    system 'clear'
    title('Oops! Invalid input, please try again.')
  end

  def another_game
    say("Do you want to play again? [Y/N]")
  end
end

class Game
  attr_accessor :player, :computer, :request, :game_text

  CHOICES = ['ROCK', 'PAPER', 'SCISSORS']

  def initialize
    Request.new.player_name
    self.player = Player.new('human')
    self.computer = Player.new('computer')
    self.game_text = GameText.new(player, computer)
    game_text.greet_player
  end

  def winner
    if player > computer
      "#{player.name}"
    elsif player < computer
      "The computer"
    else
      nil
    end
  end

  def play
    game_text.announce_new_game
    Request.new.player_choice
    player.choice = gets.chomp
    computer.choice = CHOICES.sample
    game_text.announce_choices
    game_text.announce_winner(winner)
  end

  def play_again?(response)
    loop do
      break if response.downcase == 'y' || response.downcase == 'n'
      Request.new.valid_input_please
      Request.new.another_game
      response = gets.chomp
    end
    response.downcase == 'y'
  end

  def quit
    game_text.bye
  end

end

game = Game.new
loop do
  game.play
  Request.new.another_game
  break unless game.play_again?(gets.chomp)
end
game.quit
