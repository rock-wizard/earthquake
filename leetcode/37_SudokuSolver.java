package leetcode;

import java.util.ArrayList;
import java.util.List;

class SudokuSolver {
    public void solveSudokuNormal(char[][] board) {
        boolean[][] rows = new boolean[9][9];
        boolean[][] cols = new boolean[9][9];
        boolean[][] subs = new boolean[9][9];
        List<int[]> unknowns = new ArrayList<int[]>();

        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (board[i][j] == '.') {
                    unknowns.add(new int[] { i, j });
                    continue;
                }
                int num = board[i][j] - '0' - 1;
                int subBox = (i / 3) * 3 + (j / 3);
                rows[i][num] = true;
                cols[j][num] = true;
                subs[subBox][num] = true;
            }
        }

        filling(board, rows, cols, subs, unknowns, 0);
    }

    private boolean filling(char[][] board, boolean[][] rows, boolean[][] cols, boolean[][] subs, List<int[]> unknowns,
            int cnt) {
        if (cnt == unknowns.size()) {
            return true;
        }

        int row = unknowns.get(cnt)[0], col = unknowns.get(cnt)[1];
        for (int i = 0; i < 9; i++) {
            int subBox = (row / 3) * 3 + (col / 3);
            if (rows[row][i] || cols[col][i] || subs[subBox][i]) {
                continue;
            }
            rows[row][i] = true;
            cols[col][i] = true;
            subs[subBox][i] = true;
            board[row][col] = (char) (i + '0' + 1);
            if (filling(board, rows, cols, subs, unknowns, cnt + 1)) {
                return true;
            }
            rows[row][i] = false;
            cols[col][i] = false;
            subs[subBox][i] = false;
        }
        return false;
    }
}
