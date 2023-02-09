package leetcode;

import java.util.HashSet;
import java.util.Set;

class ValidSudoku {
    public boolean isValidSudoku(char[][] board) {
        boolean[][] rows = new boolean[9][9];
        boolean[][] columns = new boolean[9][9];
        boolean[][] subs = new boolean[9][9];

        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (board[i][j] == '.') {
                    continue;
                }
                int num = board[i][j] - '1';
                int subIndex = (i / 3) * 3 + (j / 3);
                if (rows[i][num] || columns[j][num] || subs[subIndex][num]) {
                    return false;
                }
                rows[i][num] = true;
                columns[j][num] = true;
                subs[subIndex][num] = true;
            }
        }

        return true;
    }

    /*
     * Construct the key for row, column and sub-box to instead of three arrays.
     * The function add of hashset can tell ue if a key had been existed in the hashset.
     */
    public boolean isValidSudokuBetter(char[][] board) {
        Set<String> occupancy = new HashSet<String>();

        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (board[i][j] == '.') {
                    continue;
                }
                char num = board[i][j];
                int subIndex = (i / 3) * 3 + (j / 3);
                

                if (!occupancy.add(num + "row" + i) || !occupancy.add(num + "col" + j) || !occupancy.add(num + "sub" + subIndex)) {
                    return false;
                }
            }
        }
        
        return true;
    }
}
