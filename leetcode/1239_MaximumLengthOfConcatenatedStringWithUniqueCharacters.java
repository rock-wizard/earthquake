package leetcode;

import java.util.ArrayList;
import java.util.BitSet;
import java.util.List;

class MaximumLengthOfConcatenatedStringWithUniqueCharacters {
    public int maxLength(List<String> arr) {
        return construction(arr, "", 0, arr.size());
    }

    private int construction(List<String> arr, String curr, int begin, int n) {
        if (begin == n) {
            return curr.length();
        }

        int len = curr.length();
        for (int i = begin; i < n; i++) {
            if (!isValid(curr, arr.get(i))) {
                continue;
            }
            len = Math.max(len, construction(arr, curr + arr.get(i), i + 1, n));
        }

        return len;
    }

    private boolean isValid(String s1, String s2) {
        BitSet bits = new BitSet(26);
        for (char c : s1.toCharArray()) {
            if (bits.get(c - 'a')) {
                return false;
            }
            bits.set(c - 'a');
        }
        for (char c : s2.toCharArray()) {
            if (bits.get(c - 'a')) {
                return false;
            }
            bits.set(c - 'a');
        }
        return true;
    }

    // Iteration metod with integer instead of string to save memory
    public int maxLengthBetter(List<String> arr) {
        int ans = 0;
        // remove some string that has duplicate from arr
        List<Integer> uniques = new ArrayList<>();
        for (String str : arr) {
            int strLen = str.length();
            int unique = 0;
            for (char c : str.toCharArray()) {
                unique += 1 << (c - 'a');
            }
            if (Integer.bitCount(unique) == strLen) {
                uniques.add(unique);
            }
        }

        List<Integer> posibilities = new ArrayList<>();
        posibilities.add(0);
        for (int i = 0; i < uniques.size(); i++) {
            for (int j = posibilities.size() - 1; j >= 0; j--) {
                if ((uniques.get(i) & posibilities.get(j)) == 0) {
                    int posiblity = uniques.get(i) | posibilities.get(j);
                    posibilities.add(posiblity);
                    ans = Math.max(ans, Integer.bitCount(posiblity));
                }
            }
        }
        return ans;
    }

    public void solveSudoku(char[][] board) {
        int[] rows = new int[9];
        int[] cols = new int[9];
        int[] subs = new int[9];
        List<int[]> unknowns = new ArrayList<int[]>();

        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (board[i][j] == '.') {
                    unknowns.add(new int[] { i, j });
                    continue;
                }
                int num = board[i][j] - '0' - 1;
                rows[i] ^= 1 << num;
                cols[j] ^= 1 << num;
                subs[(i / 3) * 3 + (j / 3)] ^= 1 << num;
            }
        }

        while (true) {
            boolean finished = false;
            for (int i = 0; i < 9; i++) {
                for (int j = 0; j < 9; j++) {
                    if (board[i][j] != '.') {
                        continue;
                    }
                    int mask = ~(rows[i] & rows[j] & subs[(i / 3) * 3 + (j / 3)]);
                    if ((mask & (mask - 1)) == 0) {
                        int num = Integer.bitCount(mask - 1);
                        rows[i] ^= 1 << num;
                        cols[j] ^= 1 << num;
                        subs[(i / 3) * 3 + (j / 3)] ^= 1 << num;
                        board[i][j] = (char) (num + '0' + 1);
                        finished = true;
                    }
                }
            }
            if (!finished) {
                break;
            }
        }

        filling(board, rows, cols, subs, unknowns, 0);
    }

    private boolean filling(char[][] board, int[] rows, int[] cols, int[] subs, List<int[]> unknowns, int cnt) {
        if (cnt == unknowns.size()) {
            return true;
        }

        int row = unknowns.get(cnt)[0], col = unknowns.get(cnt)[1];
        for (int i = 0; i < 9; i++) {
            int subBox = (row / 3) * 3 + (col / 3);
            int lShift = 1 << i;
            if (((rows[row] | cols[col] | subs[subBox]) & lShift) != 0) {
                continue;
            }
            rows[row] ^= lShift;
            cols[col] ^= lShift;
            subs[subBox] ^= lShift;
            board[row][col] = (char) (i + '0' + 1);
            if (filling(board, rows, cols, subs, unknowns, cnt + 1)) {
                return true;
            }
            rows[row] ^= lShift;
            cols[col] ^= lShift;
            subs[subBox] ^= lShift;
        }
        return false;
    }
}
