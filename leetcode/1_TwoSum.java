package leetcode;

import java.util.HashMap;

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
        HashMap<Integer, Integer> dict = new HashMap<>();
        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];
            if (dict.containsKey(complement)) {
                return new int[] { dict.get(complement), i };
            }
            dict.put(nums[i], i);
        }
        return null;
    }
}