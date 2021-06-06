require_relative 'tic_tac_toe' #=> gives access to the class that make up the tic-tac-toe game

class TicTacToeNode #=> establishes a class
  attr_accessor :board, :next_mover_mark, :prev_move_pos #=> gives read write access to the instance variables

  POS = [
    [0,0],
    [0,1],
    [0,2],
    [1,0],
    [1,1],
    [1,2],
    [2,0],
    [2,1],
    [2,2]
  ] #=> lists all the possible positions on the tic-tac-toe board

  def initialize(board, next_mover_mark, prev_move_pos = nil) #=> initialize the class and establish the instance variables 
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator) #=> decides if the node is a loosing node 
    if board.over?
      return board.won? && board.winner != evaluator
    end #=> base case if the game is over and the board is won and the winner is not the current mark 

    if self.next_mover_mark == evaluator
      self.children.all? { |node| node.losing_node?(evaluator) } #=> It is the player's turn, and all the children nodes are losers for the player (anywhere they move they still lose)
    else
      self.children.any? { |node| node.losing_node?(evaluator) } #=> It is the opponent's turn, and one of the children nodes is a losing node for the player (assumes your opponent plays perfectly; they'll force you to lose if they can).
    end
  end

  def winning_node?(evaluator)
    if board.over?
      return board.winner == evaluator #=> if the game is over and current node is the winning node or winner
    end

    if self.next_mover_mark == evaluator
      self.children.all? { |node| node.winning_node?(evaluator) } #> It is the player's turn, and one of the children nodes is a winning node for the player (we'll be smart and take that move),
    else
      self.children.any? { |node| node.winning_node?(evaluator) } #> It is the opponent's turn, and all of the children nodes are winning nodes for the player (even TicTacToeKasparov can't beat you from here).
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_nodes = [] #=> children node array to keep track of all child nodes

    POS.each do |row, col| #=> starting to itterating through all possible 
      pos = [row, col] #=> setting pos variable [row, col]

      next unless board.empty?(pos) #=> if the board[pos] emppty continue if not empty go to the next position

      new_board = board.dup #=> dup the current board
      new_board[pos] = next_mover_mark #=> and in the next_mover_mark to the pos
      next_mover_mark = self.next_mover_mark == :x ? :o : :x #=> flipp the next move mark
      children_nodes << TicTacToeNode.new(new_board, next_mover_mark, pos) #=> create a node and add it the children nodes array
    end

    children_nodes #=> return the children_nodes
  end
end


