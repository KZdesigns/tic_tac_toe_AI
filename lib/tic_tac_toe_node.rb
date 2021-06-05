require_relative 'tic_tac_toe'


class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

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
  ]
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_nodes = []

    POS.each do |row, col|
      pos = [row, col]

      next unless board.empty?(pos)

      new_board = board.dup
      new_board[pos] = self.next_mover_mark
      next_mover_mark = self.next_mover_mark == :x ? :o : :x
      children_nodes << TicTacToeNode.new(new_board, next_mover_mark, pos)
    end

    children_nodes
  end


end


