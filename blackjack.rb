module CoreUi
  def say(msg, title = false)
    if title
      system 'clear'
      puts title.center(70, '~')
    end
    if msg
      puts  "=> #{msg}".ljust(70)
    end
  end
end

class Player
  include Comparable

  attr_accessor :name, :hand

  def initialize
    self.hand = []
    self.name = 'The dealer'
  end

  def aces
    hand.select {|card| card.rank == 'Ace'}.count
  end

  def hand_total
    aces = self.aces
    total = 0
    hand.each do |card|
      next if card.rank == 'Ace'
      total += card.value
    end
    if aces > 0
      total += aces if (total + 10 + aces > 21) || (total + aces >= 21)
      total += (10 + aces) if (total + 10 + aces <= 21)
    end
    total
  end

  def blackjack?
    hand_total == 21
  end

  def bust?
    hand_total > 21
  end

  def <=>(other)
    if (!self.bust? && self.hand_total > other.hand_total) ||
      (!self.bust? && other.bust?)
      1
    elsif self.hand_total == other.hand_total || self.bust? && other.bust?
      0
    else
      -1
    end
  end

  def hand_text(final_hands = false)
    string = ''
    hand.each_with_index do |card, index|
      if index == 0
        string += " - #{card.rank} of #{card.suit}"
      elsif self.is_a?(Human)
        string += "\n - #{card.rank} of #{card.suit}"
      elsif final_hands
        string += "\n - #{card.rank} of #{card.suit}"
      else
        string += "\n - The dealer has another, hidden card.\n\n"
      end
    end
    string
  end

  def total_string
    string = " - Total: #{hand_total}"
    string += "\n - #{name} got blackjack!" if blackjack?
    string += "\n - #{name} bust!" if bust?
    string += "\n\n"
  end

end

class Human < Player
  include CoreUi

  def initialize
    super
    x = 0
    loop do
      say("What's your name? [You must enter at least one non-space character.]",
        'Hello!')
      say "Invalid Input. Plese Try again." if x > 0
      self.name = gets.chomp.capitalize
      break unless (name == '') || (name =~ /^\s+$/ )
      x += 1
    end
  end

  def stay?
    say('Do you want to HIT or STAY?')
    input = gets.chomp.upcase
    loop do
      break if (input == 'HIT') || (input == 'STAY')
      say "Invalid input. Do you want to HIT or STAY?"
      input = gets.chomp.upcase
    end
    input == 'STAY'
  end

end

class Deck
  attr_accessor :contents, :size, :remaining_cards

  def initialize
    self.contents = Card::SUITS.each_with_object([]) do |suit, array|
      2.times do
        Card::RANKS.each_with_index do |rank, index|
          index < 9 ? value = index + 1 : value = 10
          array << Card.new(rank, suit, value)
        end
      end
    end
    contents.shuffle!
    self.size = contents.count
    self.remaining_cards = contents.count
  end

  def replenish(discard_pile)
    self.contents += discard_pile
    self.remaining_cards += discard_pile.count
    discard_pile.clear
  end

  def riffle
    cut = contents.slice!((25 + (rand 2))..51)
    cut.each_with_index do |card, index|
      contents.insert((index - 1) + (rand 2), card)
    end
  end

end

class Card
  attr_accessor :rank, :suit, :value

  RANKS = %w(Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King)
  SUITS = %w(Hearts Diamonds Spades Clubs)

  def initialize(rank, suit, value)
    self.rank = rank
    self.suit = suit
    self.value = value
  end

end

class Game
  include CoreUi

  attr_accessor :dealer, :human, :deck, :discard_pile

  def initialize
    self.dealer = Player.new
    self.deck = Deck.new
    self.human = Human.new
    self.discard_pile = []
    say("Welcome to blackjack, #{human.name}! Let's get started.")
    sleep 1
  end

  def discard_hands
    [self.dealer, self.human].each do |player|
      self.discard_pile += player.hand
      player.hand.clear
    end
    discard_pile.flatten!
  end

  def hit(player)
    dealt_card = deck.contents.shift
    player.hand << dealt_card
    deck.remaining_cards -= 1
  end

  def deal_starting_hands
    2.times do
      hit(human)
      hit(dealer)
    end
  end

  def announce_hands(final_results = false)
    say("The dealer dealt you the following hand:", "Current Hands")
    puts human.hand_text(final_results)
    puts human.total_string
    say "The dealer dealt itself:"
    puts dealer.hand_text(final_results)
    puts dealer.total_string if final_results
  end

  def human_turn
    until human.stay?
      hit(human)
      announce_hands
      break if human.blackjack? || human.bust?
    end
  end

  def dealer_turn
    until dealer.hand_total > 16
      hit(dealer)
      announce_hands
    end
    announce_hands(final_results = true)
  end

  def announce_result
    say('You win!') if human > dealer
    say('Dealer wins!') if human < dealer
    say("It's a tie!") if human == dealer
  end

  def play_again?
    say("Do you want to play again? [Y/N]")
    response = gets.chomp.upcase
    loop do
      break if response == 'Y' || response == 'N'
      say("Invalid response. Play again? [Y/N]")
      response = gets.chomp.upcase
    end
    response == 'Y'
  end

  def run
    loop do
      discard_hands
      if deck.remaining_cards < deck.size / 2
         deck.replenish(discard_pile)
         deck.riffle
       end
      deal_starting_hands
      announce_hands
      if human.blackjack?
        announce_hands(final_result = true)
        announce_result
        play_again? ? next : break
      end
      human_turn
      dealer_turn
      announce_result
      break unless play_again?
    end
    say("Bye, #{human.name}! Thanks for playing.")
  end

end

Game.new.run
