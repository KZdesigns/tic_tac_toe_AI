require_relative 'tic_tac_toe'

class TicTacToeNode
    attr_reader :board, :next_mover_mark, :prev_move_pos

    def initialize(board, next_mover_mark, prev_move_pos = nil)
        @board, @next_mover_mark, @prev_move_pos = board, next_mover_mark, prev_move_pos
    end

    def losing_node?(evaluator)
        if board.over?
            return board.won? && board.winner != evaluator
        end

        if self.next_mover_mark == evaluator
            self.children.all? { |node| node.losing_node?(evaluator) }
        else
            self.children.any? { |node| node.losing_node?(evaluator) }
        end
    end

    def winning_node?(evaluator)
        if board.over?
            return board.winner == evaluator
        end

        if self.next_mover_mark == evaluator
            self.children.any? { |node| node.winning_node?(evaluator) }
        else
            self.children.all? { |node| node.winning_node?(evaluator) }
        end
    end


    def children
        children = []

        (0..2).each do |row|
            (0..2).each do |col|
                pos = [row, col]

                next unless board.empty?(pos)

                new_board = board.dup
                new_board[pos] = self.next_mover_mark
                next_mover_mark = (self.next_mover_mark == :x ? :o : :x)
                children << TicTacToeNode.new(new_board, next_mover_mark, pos)
            end
        end

        children
    end

end
