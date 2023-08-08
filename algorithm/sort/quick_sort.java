package algorithm.sort;

public class quick_sort {
    public int[] sortArray(int[] nums) {
        divide(nums, 0, nums.length - 1);
        return nums;
    }

    private void divide(int[] nums, int lo, int hi) {
        if (lo >= hi) {
            return;
        }

        int mid = conquer(nums, lo, hi);
        divide(nums, lo, mid);
        divide(nums, mid + 1, hi);
    }

    private int conquer(int[] nums, int lo, int hi) {
        int pivot = nums[(hi - lo) / 2 + lo];

        int l = lo, r = hi;

        while (true) {
            while (nums[l] < pivot) {
                l++;
            }

            while (nums[r] > pivot) {
                r--;
            }

            if (l >= r) {
                return r;
            }

            int temp = nums[l];
            nums[l] = nums[r];
            nums[r] = temp;

            l++;
            r--;
        }
    }
}
