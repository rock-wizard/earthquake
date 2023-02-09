package leetcode;

import java.util.HashMap;
import java.util.Map;

class ContainsDuplicateII {
    public boolean containsNearbyDuplicate(int[] nums, int k) {
        Map<Integer, Integer> locations = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            if (locations.containsKey(nums[i]) && Math.abs(locations.get(nums[i]) - i) <= k) {
                return true;
            }
            locations.put(nums[i], i);
        }
        return false;
    }
}
