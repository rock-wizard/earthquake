package leetcode;

import java.util.Arrays;

class JumpGameII {
    public int jump(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 1; j <= nums[i] && i + j < n; j++) {
                dp[i + j] = Math.min(dp[i + j], dp[i] + 1);
            }
        }

        return dp[n - 1];
    }

    /*
     * for start position, each time we jump we can jump to range of positions.
     * so each range of positions, we can find the least number of jumping from that position to farthest postion, until we reach in n - 1.
     * 
     */
    public int jumpBetter(int[] nums) {
        int ans = 0, n = nums.length;
        int boundary = 0, distance = 0;

        for (int i = 0; i < n - 1; i++) {
            distance = Math.max(distance, i + nums[i]);

            if (i == boundary) {
                ans++;
                boundary = distance;
            }
        }

        return ans;
    }
}
