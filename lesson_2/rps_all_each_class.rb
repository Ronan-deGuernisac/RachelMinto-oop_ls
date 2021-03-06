MOVES = ['rock', 'paper', 'scissors']

class Move 
  def to_s
    @value
  end
end

class Rock < Move
  def initialize(value)
    @value = value
  end

  def >(other_move)
    other_move == 'scissors'
  end

  def <(other_move)
    other_move == 'paper'
  end
end

class Paper < Move
  def initialize(value)
    @value = value
  end

  def >(other_move)
    other_move == 'rock'
  end

  def <(other_move)
    other_move == 'scissors'
  end
end

class Scissors < Move
  def initialize(value)
    @value = value
  end

  def >(other_move)
    other_move == 'paper'
  end

  def <(other_move)
    other_move == 'rock'
  end
end

class Player
  attr_accessor :name, :move

  def initialize
    set_name
  end

  def choice_to_move_object(choice)
    case
    when choice == "rock"
      Rock.new(choice)
    when choice == "paper"
      Paper.new(choice)
    when choice == "scissors"
      Scissors.new(choice)
    end
  end
end

class Human < Player

  def set_name
    n = ''
    loop do
      puts "Please enter your name."
      n = gets.chomp
      break unless n.empty?
      "I'm sorry, you must enter a value."
    end
    self.name = n
  end

  def choose
    choice = ''
    loop do
      puts "Please choose rock, paper, or scissors."
      choice = gets.chomp
      break if MOVES.include?(choice)
      puts "I'm sorry, that's not a valid choice."
    end
      self.move = choice_to_move_object(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = MOVES.sample
    self.move = choice_to_move_object(choice)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Hello #{@human.name}. Welcome to Rock, Paper, Scissors!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move} and #{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move.to_s
      puts "#{human.name} won!"
    elsif human.move < computer.move.to_s
      puts "#{computer.name} won!"
    else
      puts "It's a tie."
    end
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n."
    end

    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play