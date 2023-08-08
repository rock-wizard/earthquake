package leetcode;

import java.util.Arrays;

class MergeIntervals {
    public int[][] merge(int[][] intervals) {
        Arrays.sort(intervals, (a, b) -> {
            return a[0] == b[0] ? a[1] - b[1] : a[0] - b[0];
        });

        int pos = 0;
        for (int i = 1; i < intervals.length; i++) {
            if (intervals[pos][1] >= intervals[i][0]) {
                intervals[pos][1] = Math.max(intervals[pos][1], intervals[i][1]);
            } else {
                pos++;
                intervals[pos][0] = intervals[i][0];
                intervals[pos][1] = intervals[i][1];
            }
        }

        int[][] ans = new int[pos + 1][2];
        for (int i = 0; i <= pos; i++) {
            ans[i][0] = intervals[i][0];
            ans[i][1] = intervals[i][1];
        }

        return ans;
    }
}
