WIN_COMBINATIONS = [
  [0,1,2], # Top Row
  [3,4,5], # Middle Row
  [6,7,8], # Bottom Row
  [0,3,6], # Left Column
  [1,4,7], # Middle Column
  [2,5,8], # Right Column
  [0,4,8], # Left-Right Diagonal \
  [2,4,6] # Right-Left Diagonal /
]

def display_board(board = [" ", " ", " ", " ", " ", " ", " ", " ", " "])
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  converted_input = user_input.to_i - 1
end

def move(board, space, player)
  board[space] = player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if position_taken?(board,index) == false && index.between?(0,8)
    true
  end
end

def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  desired_move = input_to_index(user_input)
  if valid_move?(board, desired_move) == true
    move(board, desired_move, current_player(board))
    display_board(board)
  else
    puts "Sorry that move is invalid"
    turn(board)
  end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space != " "
      count += 1
    end
  end
  count
end

def current_player(board)
  # if then else to ternary if
  # syntax follows: if x then y else z
  # x ? y : z
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do | win_combo |
    board[win_combo[0]] == board[win_combo[1]] && board[win_combo[1]] == board[win_combo[2]] && position_taken?(board, win_combo[0])
  end
end

def full?(board)
  board.all? do |space|
    !(space.nil? || space == " ")
  end
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  elsif !(won?(board) && full?(board)) || won?(board)
    false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end

def winner(board)
  if win = won?(board)
    board[win[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
