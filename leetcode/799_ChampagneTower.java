package leetcode;

class ChampagneTower {
    public double champagneTower(int poured, int query_row, int query_glass) {
        double[][] A = new double[100][100];
        A[0][0] = poured;

        for (int i = 0; i <= query_row; i++) {
            for (int j = 0; j <= query_glass; j++) {
                double exceed = (A[i][j] - 1.0) / 2.0;

                if (exceed > 0 && i < 99) {
                    A[i + 1][j] += exceed;
                    A[i + 1][j + 1] += exceed;
                }
            }
        }

        return Math.min(1, A[query_row][query_glass]);
    }
}
