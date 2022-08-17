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

human = Human.new('Player')
human.play
