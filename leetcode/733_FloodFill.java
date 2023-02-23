package leetcode;

import java.util.LinkedList;
import java.util.Queue;

class FloodFill {
    public int[][] floodFill(int[][] image, int sr, int sc, int color) {
        int[] axis_x = { 0, 0, -1, 1 };
        int[] axis_y = { 1, -1, 0, 0 };
        int m = image.length, n = image[0].length;

        int original = image[sr][sc];
        if (original == color) {
            return image;
        }

        Queue<int[]> q = new LinkedList<>();
        q.offer(new int[] { sr, sc });
        image[sr][sc] = color;

        while (!q.isEmpty()) {
            int[] ele = q.poll();
            int x = ele[1], y = ele[0];
            for (int i = 0; i < 4; i++) {
                int n_x = x + axis_x[i], n_y = y + axis_y[i];
                if (n_y >= 0 && n_y < m && n_x >= 0 && n_x < n && image[n_y][n_x] == original) {
                    q.offer(new int[] { n_y, n_x });
                    image[n_y][n_x] = color;
                }
            }
        }

        return image;
    }


    public int[][] floodFillDfs(int[][] image, int sr, int sc, int color) {
        int original = image[sr][sc];
        if (original == color) {
            return image;
        }

        dfs(image, sc, sr, color, original);

        return image;
    }

    private void dfs(int[][] image, int x, int y, int color, int original) {
        if (image[y][x] != original) {
            return;
        }

        int[] axis_x = {0, 0, -1, 1};
        int[] axis_y = {1, -1, 0, 0};
        int m = image.length, n = image[0].length;

        image[y][x] = color;
        for (int i = 0; i < 4; i++) {
            int n_x = x + axis_x[i], n_y = y + axis_y[i];
            if (n_y >= 0 && n_y < m && n_x >= 0 && n_x < n && image[n_y][n_x] == original) {
                dfs(image, n_x, n_y, color, original);
            }
        }
    }
}
