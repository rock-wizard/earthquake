package leetcode;

import java.util.Deque;
import java.util.LinkedList;

class WallsandGates {
    public void wallsAndGatesBfs(int[][] rooms) {
        int m = rooms.length, n = rooms[0].length, empty = Integer.MAX_VALUE;
        Deque<int[]> q = new LinkedList<>();
        int[][] dirs = { { -1, 0 }, { 1, 0 }, { 0, -1 }, { 0, 1 } };

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (rooms[i][j] == 0) {
                    q.offer(new int[] { i, j });
                }
            }
        }

        int dis = 0;
        while (!q.isEmpty()) {
            int size = q.size();
            dis++;
            for (int i = 0; i < size; i++) {
                int[] curr = q.poll();
                for (int j = 0; j < 4; j++) {
                    int x = curr[0] + dirs[j][0];
                    int y = curr[1] + dirs[j][1];

                    if (x < 0 || x >= m || y < 0 || y >= n || rooms[x][y] != empty) {
                        continue;
                    }
                    rooms[x][y] = dis;
                    q.offer(new int[] { x, y });
                }
            }
        }
    }

    public void wallsAndGates(int[][] rooms) {
        int m = rooms.length, n = rooms[0].length;
        boolean[][] visited = new boolean[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (rooms[i][j] == 0) {
                    dfs(rooms, i, j, visited, 0);
                }
            }
        }
    }

    private void dfs(int[][] rooms, int i, int j, boolean[][] visited, int dis) {
        if (i < 0 || i >= rooms.length || j < 0 || j >= rooms[i].length) {
            return;
        }

        if (rooms[i][j] == -1) {
            return;
        }

        if (visited[i][j] || rooms[i][j] < dis) {
            return;
        }

        rooms[i][j] = Math.min(rooms[i][j], dis);

        visited[i][j] = true;
        dfs(rooms, i + 1, j, visited, dis + 1);
        dfs(rooms, i - 1, j, visited, dis + 1);
        dfs(rooms, i, j + 1, visited, dis + 1);
        dfs(rooms, i, j - 1, visited, dis + 1);
        visited[i][j] = false;
    }
}
