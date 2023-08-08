package leetcode;

import java.util.Arrays;

class TwoCityScheduling {
    public int twoCitySchedCost(int[][] costs) {
        int ans = 0;
        int[] b_refund = new int[costs.length];

        for (int i = 0; i < costs.length; i++) {
            b_refund[i] = costs[i][1] - costs[i][0];
            ans += costs[i][0];
        }

        Arrays.sort(b_refund);
        for (int i = 0; i < costs.length / 2; i++) {
            ans += b_refund[i];
        }

        return ans;
    }
}
