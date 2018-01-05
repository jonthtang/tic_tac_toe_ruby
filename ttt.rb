def display_board(array)
  puts "#{array[0]} | #{array[1]} | #{array[2]}"
  puts "---------"
  puts "#{array[3]} | #{array[4]} | #{array[5]}"
  puts "---------"
  puts "#{array[6]} | #{array[7]} | #{array[8]}"
  puts
end

def turn_count(board)
  counter=1
  board.each {|marked|
  if marked == "X" || marked == "O"
    counter +=1
  end}
  return counter
end

def player_turn_message(board)
  num = turn_count(board)
  if num%2!=0
    puts "It's player one's (O) turn! Please make a move!"
  else
    puts "It's player two's (X) turn! Please make a move!"
  end
end

def computer_turn_message(board)
  num = turn_count(board)
  if num%2!=0
    puts "It's player one's (O) turn! Please make a move!"
  else
    puts "It's the computer's (X) turn! Please wait while it thinks!"
    sleep 1
  end
end

def convert_to_index (input)
  input.to_i-1
end

def move_update (board, player_input)
  num = turn_count(board)
  move = convert_to_index(player_input)
  if board[move] == "O" || board[move] == "X"
    system "clear"
    puts "Position taken! Please try again!"
  else
    if num%2!=0
      board[move] = "O"
    else
      board[move] = "X"
    end
  end
end

def board_splits_for_check(array)
 r1 = [ array[0] , array[1] , array[2] ]
 r2 = [ array[3] , array[4] , array[5] ]
 r3 = [ array[6] , array[7] , array[8] ]
 d1 = [ array[0] , array[4] , array[8] ]
 d2 = [ array[2] , array[4] , array[6] ]
 c1 = [ array[0] , array[3] , array[6] ]
 c2 = [ array[1] , array[4] , array[7] ]
 c3 = [ array[2] , array[5] , array[8] ]
 array_for_win_check = [r1, r2, r3, d1, d2, c1, c2, c3]
 return array_for_win_check
end

def win_status(arrays_in_array)
 if arrays_in_array.include?(["O","O","O"])
   puts "Player 1 (O) wins!"
   return true
 elsif arrays_in_array.include?(["X","X","X"])
   puts "Player 2 (X) wins!"
   return true
 end
end

def play_again
  puts "Play again?\nType 'yes' or 'y' to play again.\nType 'no', 'n' or 'exit' to stop the program."
  input = gets.chomp.downcase
    if input == "yes"|| input == "y"
      game_on
    elsif input == "no"|| input == "n"|| input == "exit"
      puts "Thanks for playing!"
    else
      system "clear"
      puts "I didn't understand that. Please try again."
      play_again
    end
end

def pvp_game
  board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  puts "Let's play a game. Please choose a number between 1-9. You may stop the game at any time by typing 'exit'!"
  loop do
    display_board(board)
    player_turn_message(board)
    input = gets.chomp
    if input == "exit"
      puts "Bye! Thanks for playing!"
      break
    else
      ref_array=["1","2","3","4","5","6","7","8","9"]
      if ref_array.include?(input)
        system "clear"
        move_update(board,input)
        if turn_count(board) > board.size
          puts "It's a draw! What a shame..."
          display_board(board)
          play_again
          break
        end
      else
        system "clear"
        puts "I'm sorry, your input in invalid. Please choose a number between 1-9."
      end
    end
    check_win = board_splits_for_check(board)
    if win_status(check_win) == true
      display_board(board)
      play_again
      break
    end
  end
end

def pvc_game
  board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  puts "Let's play a game. You are player '1'. Please choose a number between 1-9. You may stop the game at any time by typing 'exit'!"
  loop do
    if turn_count(board).odd?
      display_board(board)
      player_turn_message(board)
      input = gets.chomp
      if input == "exit"
        puts "Bye! Thanks for playing!"
        break
      else
        ref_array=["1","2","3","4","5","6","7","8","9"]
        if ref_array.include?(input)
          system "clear"
          move_update(board,input)
          if turn_count(board) > board.size
            puts "It's a draw! What a shame..."
            display_board(board)
            play_again
            break
          end
        else
          system "clear"
          puts "I'm sorry, your input in invalid. Please choose a number between 1-9."
        end
      end
      check_win = board_splits_for_check(board)
      if win_status(check_win) == true
        display_board(board)
        play_again
        break
      end
    else
      display_board(board)
      computer_turn_message(board)
      system "clear"
      available= board.select {|num| num.is_a? Integer}
      comp_move = available.sample
      move_update(board,comp_move)
      if turn_count(board) > board.size
        puts "It's a draw! What a shame..."
        display_board(board)
        play_again
        break
      end
      check_win = board_splits_for_check(board)
      if win_status(check_win) == true
        display_board(board)
        play_again
        break
      end
    end
  end
end

def game_on
  puts "Start a new game.\nPlease select '1' for player vs player\nPlease select '2' for player vs computer."
  input = gets.chomp
  if input == "1"
    pvp_game
  elsif input == "2"
    pvc_game
  else
    system "clear"
    puts "I didn't understand that. Please try again."
    game_on
  end
end

game_on
