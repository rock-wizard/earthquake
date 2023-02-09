package leetcode;

import java.util.HashMap;
import java.util.Map;

/*
Assume sum[i] represents the nums[0] + nums[1] + ... + nums[i-1], it means the sum of first i elements of array.

So if we wanna find a subarry that satisfy the requirement, such as:
(nums[l] + nums[l+1] + ... + nums[r]) % k = 0, it equals to:
(nums[0] + num[1] + ... + nums[r] - (nums[0] + nums[1] + ... + nums[l-1])) % k = 0 ->
(sum[r+1] - sum[l]) % k = 0
sum[l] % k = sum[r+1] %k

Did you finish the two numbers sum, it's similar now for that problem.

And there are another two things must be considered:
first, the size of subarray must be at least two.
second, the zero is also an answer.

So we declare a map to store the (leftmost sum of current position % k) as the key, and how many elements in current subarray as value.

When we find the two same remainders appear in two different postion,
one is i, and another is map.get(that remainder).

Now we should satisfy: (r + 1) - l > 1
r + 1 means the sum[r+1], there are r+1 elements.
l means the sum[l], there are l elements.
But we jusy need the gap from index(l) to index(r).
so we got this equatient.

(r + 1) - l > 1
-> i + 1 - map.get(remainder) > 1
-> i > map.get(remainder)
*/

class ContinuousSubarraySum {
    public boolean checkSubarraySum(int[] nums, int k) {
        Map<Integer, Integer> dict = new HashMap<Integer, Integer>();
        dict.put(0, 0);

        int sum = 0;
        for (int i = 0; i < nums.length; i++) {
            sum += nums[i];
            int remainder = sum % k;
            if (!dict.containsKey(remainder)) {
                dict.put(remainder, i + 1);
            } else if (i > dict.get(remainder)) {
                return true;
            }
        }
        return false;
    }
}
