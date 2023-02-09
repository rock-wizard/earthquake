package leetcode;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/*
 * There are somes requirements: 
 * 1. No duplicate triplets
 * 2. For each triplet, three of numbers can be same, but the index of them cannot.
 * 3. The plus of three numbers must equal to 0.
 * 
 * So each of the three numbers is used only once with a specific number.
 * Put another way, we should deduplicate for three numbers(first, second, number).
 * 
 * We can set the first number as target from 0 to n without any duplicate.
 * and we now simply the three sum question to two sum question with a specific target.
 * - > How to duplicate to first number 
 * = > just sort the nums, and ignore which number you had iterated.
 * 
 * - > How to find two numbers that satisfy the plus of them is equal to target and there no dumplicate doublets answers.
 * = > We use two pointers to solve this problem:
 *     We assume target is in index i, so we set l pointer in index i+1, and r pointer in index n.
 *     if nums[l]+nums[r]==target, we get a answer.
 *     In this case, if we want to get another answer is equal to target, we should decreas the nums[l] and increase the nums[r]
 *     So we do l++ and r--, and the most imporant thing we should ignore the same number that we had used.
 * 
 *     if nums[l]+nums[r]>target, move the r, do r--
 *     if nums[l]+nums[r]<target, more the l, do l++
 * 
 * There are a tricky, it first numebr is greater than 0, you can return the ans directly.
 * Because we sort the numen from little to big, so if the smallest one is greater than 0, we cannot find more answers.
 * 
 */

class ThreeSum {
    public List<List<Integer>> threeSum(int[] nums) {
        Arrays.sort(nums);
        List<List<Integer>> ans = new ArrayList<>();
        for (int i = 0; i < nums.length - 2; i++) {
            if (i > 0 && nums[i] == nums[i - 1]) {
                continue;
            }
            int l = i + 1, r = nums.length - 1;
            while (l < r) {
                if (nums[i] + nums[l] + nums[r] == 0) {
                    ans.add(Arrays.asList(nums[i], nums[l], nums[r]));
                    while (l < r && nums[l] == nums[l + 1]) {
                        l++;
                    }
                    while (l < r && nums[r] == nums[r - 1]) {
                        r--;
                    }
                    l++;
                    r--;
                } else if (nums[i] + nums[l] + nums[r] > 0) {
                    r--;
                } else {
                    l++;
                }
            }
        }
        return ans;
    }
}
