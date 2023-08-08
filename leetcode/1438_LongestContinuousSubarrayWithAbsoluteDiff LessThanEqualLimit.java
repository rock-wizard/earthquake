package leetcode;

import java.util.Deque;
import java.util.LinkedList;

class Solution {
      public static int longestSubarray(int[] nums, int limit) {
        Deque<Integer> max_q = new LinkedList<>();
        Deque<Integer> min_q = new LinkedList<>();

        int ans = 0;
        for (int l = 0, r = 0; r < nums.length; r++) {
            while (!max_q.isEmpty() && max_q.peekLast() < nums[r]) {
                max_q.pollLast();
            }
            max_q.add(nums[r]);

            while (!min_q.isEmpty() && min_q.peekLast() > nums[r]) {
                min_q.pollLast();
            }
            min_q.add(nums[r]);

            while (Math.abs(min_q.peek() - max_q.peek()) > limit) {
                if (max_q.peek() == nums[l]) {
                    max_q.poll();
                }
                if (min_q.peek() == nums[l]) {
                    min_q.poll();
                }
                l++;
            }

            ans = Math.max(ans, r - l + 1);
        }

        return ans;
    }

    public static void main(String[] args) {
        int[] nums = { 10, 1, 2, 4, 7, 2 };
        longestSubarray(nums, 5);
    }
}