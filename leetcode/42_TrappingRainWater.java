package leetcode;

class TrappingRainWater {
    public int trap(int[] height) {
        if (height.length <= 2) {
            return 0;
        }

        int ans = 0, n = height.length;
        int[] left_max = new int[n];
        int[] right_max = new int[n];

        // find the left highest wall for i
        left_max[0] = height[0];
        for (int i = 1; i < n; i++) {
            left_max[i] = Math.max(height[i], left_max[i - 1]);
        }

        right_max[n - 1] = height[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            right_max[i] = Math.max(height[i], right_max[i + 1]);
        }

        for (int i = 1; i < n - 1; i++) {
            ans += Math.min(left_max[i], right_max[i]) - height[i];
        }

        return ans;
    }
}
