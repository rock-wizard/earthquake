package leetcode;

class ImageOverlap {
    public int largestOverlap(int[][] img1, int[][] img2) {
        int ans = 0;
        for (int y = 0; y < img1.length; y++)
            for (int x = 0; x < img1.length; x++) {
                ans = Math.max(ans, shiftAction(x, y, img1, img2));
                ans = Math.max(ans, shiftAction(x, y, img2, img1));
            }

        return ans;
    }

    private int shiftAction(int x, int y, int[][] moved, int[][] fixed) {
        int leftShift = 0, rightShift = 0;
        int i = 0;
        for (int row = y; row < moved.length; row++) {
            int j = 0;
            for (int col = x; col < moved.length; col++) {
                if (moved[row][col] == 1 && fixed[i][j] == 1) {
                    leftShift++;
                }
                if (moved[row][j] == 1 && fixed[i][col] == 1) {
                    rightShift++;
                }
                j++;
            }
            i++;
        }
        return Math.max(leftShift, rightShift);
    }
}
