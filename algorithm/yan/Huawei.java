package algorithm.yan;

public class Huawei {
    public static int solution(int[][] cubes) {
        int ans = 0;
        int m = cubes.length, n = cubes[0].length;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int sum = 1 + 1 + 4 * cubes[i][j];
                if (i > 0) {
                    int height = cubes[i - 1][j];
                    sum = sum - Math.min(height, cubes[i][j]);
                }
                if (i < m - 1) {
                    int height = cubes[i + 1][j];
                    sum = sum - Math.min(height, cubes[i][j]);
                }
                if (j > 0) {
                    int height = cubes[i][j - 1];
                    sum = sum - Math.min(height, cubes[i][j]);
                }
                if (j < n - 1) {
                    int height = cubes[i][j + 1];
                    sum = sum - Math.min(height, cubes[i][j]);
                }
                ans += sum;
            }
        }
        return ans;
    }

    public static void main(String[] args) {
        int[][] cubes = new int[3][3];
        cubes[0][0] = 1;
        cubes[0][1] = 3;
        cubes[0][2] = 4;

        cubes[1][0] = 2;
        cubes[1][1] = 2;
        cubes[1][2] = 3;

        cubes[2][0] = 1;
        cubes[2][1] = 2;
        cubes[2][2] = 4;

        System.out.println(solution(cubes));
    }
}
