package leetcode;

class WhereWillTheBallFall {
    public int[] findBall(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[] ans = new int[n];
        for (int i = 0; i < n; i++) {
            ans[i] = dfs(grid, i, m);
        }
        return ans;
    }

    private int dfs(int[][] grid, int col, int m) {
        for (int i = 0; i < m; i++) {
            if (grid[i][col] == 1 && (col == grid[i].length - 1 || grid[i][col + 1] == -1)) {
                return -1;
            }
            if (grid[i][col] == -1 && (col == 0 || grid[i][col - 1] == 1)) {
                return -1;
            }
            if (grid[i][col] == 1) {
                col = col + 1;
            } else {
                col = col - 1;
            }
        }
        return col;
    }
}
