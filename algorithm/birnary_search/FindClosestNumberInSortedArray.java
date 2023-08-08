package algorithm.birnary_search;

public class FindClosestNumberInSortedArray {
    public static int findClosest(int[] arr, int n, int target) {
        int left = 0, right = n - 1;
        while (left < right) {
            if (Math.abs(arr[left] - target) <= Math.abs(arr[right] - target)) {
                right--;
            } else {
                left++;
            }
        }
        return arr[left];
    }

    public static void main(String[] args) {
        int[] arr = { 1, 2, 4, 5, 6, 6, 8, 8, 9 };
        int n = arr.length;
        int target = 11;
        System.out.println(findClosest(arr, n, target));
    }

    public static int search(int value, int[] a) {
        if (value < a[0]) {
            return a[0];
        }
        if (value > a[a.length - 1]) {
            return a[a.length - 1];
        }

        int lo = 0;
        int hi = a.length - 1;

        while (lo <= hi) {
            int mid = (hi + lo) / 2;

            if (value < a[mid]) {
                hi = mid - 1;
            } else if (value > a[mid]) {
                lo = mid + 1;
            } else {
                return a[mid];
            }
        }
        // lo == hi + 1
        return (a[lo] - value) < (value - a[hi]) ? a[lo] : a[hi];
    }
}
