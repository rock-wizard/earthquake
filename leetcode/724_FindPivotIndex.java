package leetcode;

class FindPivotIndex {
    public int pivotIndex(int[] nums) {
        int l_sum = 0, sum = 0, n = nums.length;

        for (int i = 0; i < n; i++) {
            sum += nums[i];
        }

        for (int i = 0; i < n; i++) {
            if (l_sum == sum - l_sum - nums[i]) {
                return i;
            }
            l_sum += nums[i];
        }

        return -1;
    }
}
