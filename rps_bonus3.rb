VALID_LETTERS = %w(r p s l sp)

player_win_count = 0
computer_win_count = 0
player_choice = ''
computer_choice = ''
selection = ''

def win?(first, second)
  (first == 'r' && second == 's') ||
  (first == 'r' && second == 'l') ||
  (first == 'p' && second == 'r') ||
  (first == 'p' && second == 'sp') ||
  (first == 's' && second == 'p') ||
  (first == 's' && second == 'l') ||
  (first == 'l' && second == 'p') ||
  (first == 'l' && second == 'sp') ||
  (first == 'sp' && second == 's') ||
  (first == 'sp' && second == 'r')
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It is a tie!")
  end
end

def win_count(player, computer)
  wins = 0
  if win?(player, computer)
    wins += 1
  end
  wins
end

def find_winner(player, computer)
  if player == 5
    prompt("You are the winner!")
  elsif computer == 5
    prompt("Computer wins!")
  end
end

loop do
  loop do
    selection = <<-HEREDOC
    'r' for rock 
    'p' for paper 
    's' for scissors
    'l' for lizard 
    'sp' for spock")
    HEREDOC

    prompt("Choose one: \n#{selection}")

    loop do
      player_choice = Kernel.gets().chomp()
      if VALID_LETTERS.include?(player_choice)
        break
      else
        prompt("You have entered an invalid choice, choose again")
      end
    end

    computer_choice = VALID_LETTERS.sample

    prompt("You chose #{player_choice} and Computer chose #{computer_choice}")
    display_results(player_choice, computer_choice)
    player_win_count += win_count(player_choice, computer_choice)
    computer_win_count += win_count(computer_choice, player_choice)
    prompt("Wins: You:- #{player_win_count}, Computer:- #{computer_win_count}")
    break if player_win_count == 5 || computer_win_count == 5
  end
  puts find_winner(player_win_count, computer_win_count)
  prompt("Will you like to play again? 'y' for yes, any key to quit")
  response = Kernel.gets().chomp()
  break if response.match(/[^y]/i)
  puts "\e[H\e2J"
end
prompt("Thank you for playing, goodbye!")
