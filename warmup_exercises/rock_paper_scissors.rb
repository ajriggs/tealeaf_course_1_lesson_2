# Contains states for player names and choices, as well as an interface for
# the rest of the code to interact w/ these states.
class Player

  include Comparable

  attr_reader :name, :choice

  def name=(name)
    loop do
      break unless name == '' || name =~ /^\s+$/
      GameText.invalid_input_message
      GameText.request_player_name
      name = gets.chomp
    end
    @name = name.capitalize
  end

  def choice=(choice)
    loop do
      break if (choice.upcase == 'ROCK') || (choice.upcase == 'PAPER') ||
      (choice.upcase == 'SCISSORS')
      GameText.invalid_input_message
      GameText.request_player_choice
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

# GameText contains all UI put to the screen, and (almost) no logic.
class GameText

  def self.title(title)
    puts title.center(62, '~')
  end

  def self.say(msg)
    puts  "=> #{msg}".ljust(62)
  end

  def self.request_player_name
    system 'clear'
    title("What's your name?")
    say("Please enter a name or alias:")
  end

  def self.invalid_input_message
    system 'clear'
    title('Oops! Invalid input, try again.')
  end

  def self.greet_player(player)
    say("Hi #{player.name}! Let's play!")
    sleep 1
  end

  def self.announce_new_game
    system 'clear'
    title("Let's Play Rock-Paper-Scissors!")
  end

  def self.request_player_choice
    say("Which do you choose? [ROCK, PAPER, or SCISSORS]")
  end

  def self.announce_choices(player, computer)
    system 'clear'
    title("Results")
    say("#{player.name} chose #{player.choice}.")
    say("The computer chose #{computer.choice}.")
  end

  def self.announce_winner(winner)
    say("#{winner} wins!") if winner
    say("It's a tie!") if !winner
  end

  def self.request_another_game
    say("Do you want to play again? [Y/N]")
  end

  def self.announce_final_standings(player)
    system 'clear'
    title("Final Standings!")
    say("#{player.name}'s wins: #{Game.player_win_count} \n"\
    "   Computer's wins: #{Game.computer_win_count} \n"\
    "   Ties: #{Game.tie_count}")
  end
end

# Game-level logic implementation. Executes the game, allows user to play games
# in succession, and tracks match statistics.
class Game

  CHOICES = ['ROCK', 'PAPER', 'SCISSORS']
  @@tie_count = 0
  @@player_win_count = 0
  @@computer_win_count = 0

  def self.winner(player, computer)
    if player > computer
      @@player_win_count += 1
      "#{player.name}"
    elsif player < computer
      @@computer_win_count += 1
      "The computer"
    else
      @@tie_count += 1
      nil
    end
  end

  def self.prepare_to_play(player)
    GameText.request_player_name
    player.name=(gets.chomp)
    GameText.greet_player(player)
  end

  def self.play(player, computer)
    GameText.announce_new_game
    GameText.request_player_choice
    player.choice=(gets.chomp)
    computer.choice=(CHOICES.sample)
    GameText.announce_choices(player, computer)
    winner = Game.winner(player, computer)
    GameText.announce_winner(winner)
  end

  def self.player_win_count
    @@player_win_count
  end

  def self.computer_win_count
    @@computer_win_count
  end

  def self.tie_count
    @@tie_count
  end

  def self.play_again?(response)
    loop do
      break if response.downcase == 'y' || response.downcase == 'n'
      GameText.invalid_input_message
      GameText.request_another_game
      response = gets.chomp
    end
    false
    if response.downcase == 'y'
      true
    end
  end

end

player = Player.new
computer = Player.new
Game.prepare_to_play(player)
loop do
  Game.play(player, computer)
  GameText.request_another_game
  break unless Game.play_again?(gets.chomp)
end
GameText.announce_final_standings(player)
