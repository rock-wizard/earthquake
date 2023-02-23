package leetcode;

import java.util.HashMap;
import java.util.Map;

/*
 * While I'm iterating the nums arry, I should look back which number is equal to the difference of target and current number.
 * If I find it, I get the answer.
 * 
 * 
 * So based on this idea, 
 * I should store each number and its index and determine if current number's complement already iterated while I'm iterating this nums array.
 * Why do I choose the hasp map to store data, the only reason is it can search quickly.
 * 
 */

class TwoSum {
    public int[] twoSum(int[] nums, int target) {
        Map<Integer, Integer> remainder = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            if (remainder.containsKey(target - nums[i])) {
                return new int[]{remainder.get(target - nums[i]), i};
            }
            remainder.put(nums[i], i);
        }

        return null;
    }
}