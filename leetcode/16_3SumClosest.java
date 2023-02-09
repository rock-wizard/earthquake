package leetcode;

import java.util.Arrays;

/*
 * There are two important things:
 * 1: In the iterator process, we should jumo some duplicates.
 * 2: We should do short cuts.
 * 
 * The initial ans is num[0] + nums[l] + num[n-1], It means the first combination of three numbers.
 * If the target is less than the sum of three most smallest numbers, it means sum is the answer.
 * If the target is greater than the sum of threee most largest numbers, it means sum it the answer;
 * 
 * if target == sum, just return the answer directly.
 * if target > sum, move the left boundary.
 * if target < sum, move the right boundary.
 * 
 * For each move, please remember to ignore the duplicates.
 * 
 * For each combinataion of three numbers, should use abs to determiner if new sum is near to the target.
 * 
 */
class ThreeSumClosest {
    public int threeSumClosest(int[] nums, int target) {
        if (nums == null || nums.length < 3) {
            return 0;
        }
        Arrays.sort(nums);
        int n = nums.length;
        int ans = nums[0] + nums[1] + nums[n - 1];
        int MIN = nums[0] + nums[1] + nums[2], MAX = nums[n - 3] + nums[n - 2] + nums[n - 1];
        if (target > MAX) {
            return MAX;
        }
        if (target < MIN) {
            return MIN;
        }

        for (int i = 0; i < n - 2; i++) {
            if (i > 0 && nums[i] == nums[i - 1]) {
                continue;
            }
            int l = i + 1, r = n - 1;
            while (l < r) {
                int sum = nums[i] + nums[l] + nums[r];
                ans = Math.abs(target - sum) < Math.abs(target - ans) ? sum : ans;
                if (sum > target) {
                    while (l < r && nums[r] == nums[r - 1]) {
                        r--;
                    }
                    r--;
                } else if (sum < target) {
                    while (l < r && nums[l] == nums[l + 1]) {
                        l++;
                    }
                    l++;
                }
                if (sum == target) {
                    return sum;
                }
            }
        }
        return ans;
    }
}
