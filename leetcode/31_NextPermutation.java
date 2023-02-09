package leetcode;

import java.util.Arrays;

class NextPermutation {
    public void nextPermutation(int[] nums) {
        int i = -1, n = nums.length;
        for (int j = n - 1; j > 0; j--) {
            if (nums[j - 1] < nums[j]) {
                i = j - 1;
                break;
            } 
        }

        if (i == -1) {
            Arrays.sort(nums);
            return;
        }

        for (int j = n - 1; j > i; j-- ){
            if (nums[j] <= nums[i]) {
                continue;
            }
            int temp = nums[i];
            nums[i] = nums[j];
            nums[j] = temp;
            break;
        }

        Arrays.sort(nums, i + 1, n);
    }

    public void nextPermutationBetter(int[] nums) {
        int l = -1, n = nums.length - 1;
        for (int i = n; i > 0; i--) {
            if (nums[i - 1] < nums[i]) {
                l = i - 1;
                break;
            }
        }
        
        int r = n;
        if (l >= 0) {
            for (int i = n; i > l; i--) {
                if (nums[l] < nums[i]) {
                    r = i;
                    break;
                }
            }
            swap(nums, l, r);
        }
    
        reverse(nums, l + 1, n);
    }

    private void swap(int[] nums, int i, int j) {
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }

    private void reverse(int[] nums, int i, int j) {
        while(i < j) {
            swap(nums, i, j);
            i++;
            j--;
        }
    }
}


