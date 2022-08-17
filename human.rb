# frozen_string_literal: true

# player's behaviors
class Human
  attr_reader :computer_code

  def initialize(name)
    @name = name
    random_numbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    @computer_code = random_numbers.map(&:to_s)
    @guess = []
  end

  def guess_enter
    print ' Enter your guess: '
    gets.chomp.split('')
  end

  def solved?
    @guess == @computer_code
  end

  def display_clues(correct_position, correct_color)
    print @guess.join('')
    print "\t"
    correct_position.times { print 'o' }
    correct_color.times { print 'x' }
    print "\n"
  end

  def turn_result
    correct_position = 0
    correct_color = 0
    @guess.each_with_index do |guess, index|
      if guess == @computer_code[index]
        correct_position += 1
      elsif @computer_code.include?(guess)
        correct_color += 1
      end
    end
    display_clues(correct_position, correct_color)
  end

  def game_result
    if solved?
      "Congratulations #{@name}! You won the game!"
    else
      "Sorry #{@name}, you lost the game."
    end
  end

  def play
    turn = 1
    while turn <= 12
      print "Turn #{turn} "
      @guess = guess_enter
      turn += 1
      break if solved?

      turn_result
    end
    puts "Master code: #{@computer_code.join('')}"
    puts game_result
  end
end

# computer's behaviors
class Computer
  attr_reader :possible_guesses

  def initialize
    random_numbers = [rand(1..6), rand(1..6), rand(1..6), rand(1..6)]
    @computer_code = random_numbers.map(&:to_s)
    @guess = []
    @possible_guesses = []
  end

  def choices
    6667.times do |i|
      possibility = [i / 1000, (i / 100) % 10, (i / 10) % 10, i % 10]
      test_s = possibility.join('')
      unless test_s.include?('7') || test_s.include?('8') || test_s.include?('9') || test_s.include?('0')
        @possible_guesses.push(possibility)
      end
    end
  end

  def generate_guess
    print ' Enter your guess: '
    gets.chomp.split('')
  end

  def solved?
    @guess == @computer_code
  end

  def display_clues(correct_position, correct_color)
    print @guess.join('')
    print "\t"
    correct_position.times { print 'o' }
    correct_color.times { print 'x' }
    print "\n"
  end

  def turn_result
    correct_position = 0
    correct_color = 0
    @guess.each_with_index do |guess, index|
      if guess == @computer_code[index]
        correct_position += 1
      elsif @computer_code.include?(guess)
        correct_color += 1
      end
    end
    display_clues(correct_position, correct_color)
  end

  def game_result
    if solved?
      "Congratulations #{@name}! You won the game!"
    else
      "Sorry #{@name}, you lost the game."
    end
  end

  def play
    turn = 1
    while turn <= 12
      print "Turn #{turn} "
      @guess = turn == 1 ? [1, 2, 2, 1] : generate_guess
      turn += 1
      break if solved?

      turn_result
    end
  end
end

# human = Human.new('Player')
# human.play
computer = Computer.new
computer.choices
p computer.possible_guesses
p computer.possible_guesses.length
