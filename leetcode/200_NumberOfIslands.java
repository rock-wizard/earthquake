package leetcode;

import java.util.LinkedList;
import java.util.Queue;

class NumberOfIslands {
    public int numIslands(char[][] grid) {
        int ans = 0;
        int m = grid.length, n = grid[0].length;
        int[] axis_x = { 1, -1, 0, 0 };
        int[] axis_y = { 0, 0, -1, 1 };

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] != '1') {
                    continue;
                }

                ans++;
                grid[i][j] = '2';
                Queue<int[]> q = new LinkedList<>();
                q.offer(new int[] { i, j });

                while (!q.isEmpty()) {
                    int[] ele = q.poll();
                    int y = ele[0], x = ele[1];
                    for (int k = 0; k < 4; k++) {
                        int n_y = y + axis_y[k];
                        int n_x = x + axis_x[k];
                        if (n_y >= 0 && n_y < m && n_x >= 0 && n_x < n && grid[n_y][n_x] == '1') {
                            q.offer(new int[] { n_y, n_x });
                            grid[n_y][n_x] = '2';
                        }
                    }
                }

            }
        }
        return ans;
    }

    public int numIslandsDfs(char[][] grid) {
        int ans = 0;
        int m = grid.length, n = grid[0].length;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == '1') {
                    ans++;
                    dfs(grid, i, j, m, n);
                }
            }
        }

        return ans;
    }

    private void dfs(char[][] grid, int i, int j, int m, int n) {
        if (i < 0 || i >= m || j < 0 || j >= n) {
            return;
        }

        if (grid[i][j] != '1') {
            return;
        }

        grid[i][j] = '2';
        dfs(grid, i + 1, j, m, n);
        dfs(grid, i - 1, j, m, n);
        dfs(grid, i, j + 1, m, n);
        dfs(grid, i, j - 1, m, n);
    }
}
