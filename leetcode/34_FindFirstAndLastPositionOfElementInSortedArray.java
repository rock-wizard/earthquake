package leetcode;

class FindFirstAndLastPositionOfElementInSortedArray {
    public int[] searchRange(int[] nums, int target) {
        if (nums == null || nums.length == 0) {
            return new int[] { -1, -1 };
        }
        return new int[] { searchLeft(nums, target), searchRight(nums, target) };
    }

    private int searchLeft(int[] nums, int target) {
        int l = 0, r = nums.length - 1;

        while (l <= r) {
            int mid = r - (r - l) / 2;
            if (target == nums[mid]) {
                if (mid > 0 && nums[mid - 1] == target) {
                    r = mid - 1;
                    continue;
                }
                return mid;
            } else if (target > nums[mid]) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
        return -1;
    }

    private int searchRight(int[] nums, int target) {
        int l = 0, r = nums.length - 1;

        while (l <= r) {
            int mid = r - (r - l) / 2;
            if (target == nums[mid]) {
                if (mid < nums.length - 1 && nums[mid + 1] == target) {
                    l = mid + 1;
                    continue;
                }
                return mid;
            } else if (target > nums[mid]) {
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
        return -1;
    }
}
