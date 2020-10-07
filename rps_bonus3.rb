GAME_LOGIC = { r: ['s', 'l'],
               p: ['r', 'sp'],
               s: ['p', 'l'],
               l: ['sp', 'p'],
               sp: ['s', 'r'] }

VALID_LETTERS = %w(r p s l sp)
TOURNAMENT = 5
VALID_RESPONSE = %w(y yes n no)

def win?(first, second)
  GAME_LOGIC[first.to_sym].include?(second)

  # (first == 'r') && (second == 's') ||
  #   (first == 'r' && second == 'l') ||
  #   (first == 'p' && second == 'r') ||
  #   (first == 'p' && second == 'sp') ||
  #   (first == 's' && second == 'p') ||
  #   (first == 's' && second == 'l') ||
  #   (first == 'l' && second == 'p') ||
  #   (first == 'l' && second == 'sp') ||
  #   (first == 'sp' && second == 's') ||
  #   (first == 'sp' && second == 'r')
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def meet_and_greet
  prompt("Welcome to Sulaiman's Rock, Paper, Scissors, Lizard, Spock game.
    What is your name:")
end

def get_name
  name = ''
  loop do
    name = Kernel.gets().chomp()
    if name_valid?(name)
      break
    else
      prompt('You have entered an invalid name, please enter your name')
    end
  end
  name
end

def name_valid?(string)
  string.match(/[a-z]/i) && !string.empty?()
end

def display_goal(player_name)
  prompt('Hello' + player_name + ',' + 'you play against the computer,
  the first to get to ' + TOURNAMENT.to_s + ' wins overall !')
end

def display_play_options
  <<-HEREDOC
  Choose one:
  'r' for rock 
  'p' for paper 
  's' for scissors
  'l' for lizard 
  'sp' for spock
  HEREDOC
end

def get_player_choice
  player_choice = ''
  loop do
    player_choice = Kernel.gets().chomp().downcase
    if VALID_LETTERS.include?(player_choice)
      break
    else
      prompt("You have entered an invalid choice, choose again")
    end
  end
  player_choice
end

def display_players_choices(first, second)
  prompt("You chose #{choice_to_display(first)} and Computer chose
    #{choice_to_display(second)}")
end

def display_result(player, computer)
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

def display_winner(player, computer)
  if player == TOURNAMENT
    prompt("You are the winner!")
  elsif computer == TOURNAMENT
    prompt("Computer wins!")
  end
end

def choice_to_display(option)
  word = case option
         when 'r'
           'Rock'
         when 'p'
           'Paper'
         when 's'
           'Scissors'
         when 'l'
           'Lizard'
         when 'sp'
           'Spock'
         end
  word
end

def show_wins(player_count, computer_count)
  prompt("Wins: You: #{player_count}, Computer: #{computer_count}")
end

def play_again?
  prompt('Will you like to play again? Enter Y/Yes, or N/No')
  answer = ''
  loop do
    answer = Kernel.gets().chomp().downcase
    if valid_response?(answer)
      break
    else
      prompt('Invalid entry, please enter Y or Yes to continue, N or No
        to exit')
    end
  end
  answer
end

def valid_response?(string)
  VALID_RESPONSE.include?(string) && !string.empty?()
end

def reset_win_counter
  0
end

player_win_count = 0
computer_win_count = 0
player_choice = ''
computer_choice = ''

meet_and_greet()
name = get_name()
display_goal(name)

loop do
  loop do
    prompt(display_play_options())
    player_choice = get_player_choice()
    computer_choice = VALID_LETTERS.sample
    display_players_choices(player_choice, computer_choice)
    display_result(player_choice, computer_choice)
    player_win_count += win_count(player_choice, computer_choice)
    computer_win_count += win_count(computer_choice, player_choice)
    show_wins(player_win_count, computer_win_count)
    break if player_win_count == TOURNAMENT || computer_win_count == TOURNAMENT
  end
  display_winner(player_win_count, computer_win_count)
  response = play_again?()
  break if response == 'n' || response == 'no'
  player_win_count = reset_win_counter()
  computer_win_count = reset_win_counter()
  puts "\e[H\e[2J"
end
prompt("Thank you for playing, goodbye!")
