package leetcode;

class MedianOfTwoSortedArrays {
    public double findMedianSortedArraysBetter(int[] nums1, int[] nums2) {
        int numL = 0, numR = 0;
        int m = nums1.length, n = nums2.length, mid = (m + n) / 2;
        int l = 0, r = 0;

        for (int i = 0; i <= mid; i++) {
            int num = 0;
            if (l < m && r < n) {
                num = nums1[l] < nums2[r] ? nums1[l++] : nums2[r++];
            } else if (l < m) {
                num = nums1[l++];
            } else {
                num = nums2[r++];
            }
            numL = numR;
            numR = num;
        }

        return (m + n) % 2 == 0 ? (numL + numR) / 2 : numR;
    }

    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        double ans = 0.0;
        int m = nums1.length, n = nums2.length, mid = (m + n) / 2;
        int l = 0, r = 0;

        for (int i = 0; i <= mid; i++) {
            int num = 0;

            if (l < m && r < n) {
                if (nums1[l] < nums2[r]) {
                    num = nums1[l];
                    l++;
                } else {
                    num = nums2[r];
                    r++;
                }
            } else if (l < m) {
                num = nums1[l];
                l++;
            } else if (r < n) {
                num = nums2[r];
                r++;
            }

            if (i == mid - 1 && (m + n) % 2 == 0) {
                ans += num;
            }
            if (i == mid) {
                ans += num;
            }
        }

        return (m + n) % 2 != 0 ? ans : ans / 2.0;
    }
}
