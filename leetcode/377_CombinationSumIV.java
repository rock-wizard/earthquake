package leetcode;

import java.util.Arrays;

class CombinationSumIV {
    public int combinationSum4(int[] nums, int target) {
        int dp[] = new int[target + 1];
        dp[0] = 1;

        for (int i = 0; i < target + 1; i++) {
            for (int num : nums) {
                if (i - num >= 0) {
                    dp[i] = dp[i] + dp[i - num];
                }
            }
        }

        return dp[target];
    }

    int[] dp;

    public int combinationSum4Dfs(int[] nums, int target) {
        dp = new int[target + 1];
        Arrays.fill(dp, -1);
        Arrays.sort(nums);
        return dfs(nums, target);
    }

    private int dfs(int[] nums, int target) {
        if (dp[target] != -1) {
            return dp[target];
        }
        if (target == 0) {
            return 1;
        }

        int ans = 0;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] > target) {
                break;
            }
            ans += dfs(nums, target - nums[i]);
        }
        dp[target] = ans;

        return ans;
    }
}
