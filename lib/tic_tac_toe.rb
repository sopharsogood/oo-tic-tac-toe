class TicTacToe
    attr_reader :board

    WIN_COMBINATIONS = [[0,1,2],
                        [3,4,5],
                        [6,7,8],
                        [0,3,6],
                        [1,4,7],
                        [2,5,8],
                        [0,4,8],
                        [2,4,6]]

    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
        puts "-----------"
        puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
        puts "-----------"
        puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token)
        self.board[index] = token
    end

    def position_taken?(index)
        self.board[index] != " "
    end

    def valid_move?(index)
        !position_taken?(index) && (0..8).to_a.include?(index)
    end

    def turn_count
        9 - self.board.select {|entry| entry == " "}.length
    end

    def current_player
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn
        puts "Where will you move? (1-9)"
        index = input_to_index(gets.strip)
        unless valid_move?(index)
            puts "Invalid move."
            self.turn
        end
        move(index, current_player)
        display_board
    end

    def won?
        WIN_COMBINATIONS.each do |triplet|
            if board[triplet[0]] == board[triplet[1]] && board[triplet[0]] == board[triplet[2]] && board[triplet[0]] != " "
                # if the three in a row all match and aren't blank
                return triplet
            end
        end
        return nil
    end

    def full?
        self.turn_count == 9
    end

    def draw?
        self.full? && !self.won?
    end

    def over?
        self.draw? || self.won?
    end

    def winner
        return board[self.won?[0]] if self.won?
        return nil
    end

    def play
        until self.over?
            self.turn
        end
        puts "Congratulations #{winner}!" if won?
        puts "Cat's Game!" if draw?
    end
end