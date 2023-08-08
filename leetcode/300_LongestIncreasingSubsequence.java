package leetcode;

import java.util.ArrayList;
import java.util.List;

class LongestIncreasingSubsequence {
    public int lengthOfLIS(int[] nums) {
        List<Integer> path = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (path.isEmpty() || path.get(path.size() - 1) < nums[i]) {
                path.add(nums[i]);
            } else if (path.contains(nums[i])) {
                continue;
            } else {
                int l = 0, r = path.size() - 1;
                while (l <= r) {
                    int mid = (l + r) / 2;
                    if (path.get(mid) > nums[i]) {
                        r = mid - 1;
                    } else {
                        l = mid + 1;
                    }
                }
                path.set(l, nums[i]);
            }
        }
        return path.size();
    }
}
