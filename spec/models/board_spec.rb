require "spec_helper"

describe Board do
  describe '#new' do
    context 'Initialize with 6 rows and 7 cols' do
      it 'create a 6*7 board' do
        board = Board.new(6, 7)
        expect(board.row).to eq(6)
        expect(board.col).to eq(7)
        expect(board.body.size).to eq(7)
      end
    end
  end

  describe '#accept_token' do

    let (:board) { Board.new(6, 7) }

    context 'insert token to col 1 with role P1' do
      it 'token fallen to col 1 and row 1' do
        board.accept_token(1, 'P1')
        expect(board.body[0][6-1]).to eq('P1')
      end
    end
  end
end