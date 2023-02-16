package leetcode;

class BestTimeToBuyandSellStock {
    public int maxProfit(int[] prices) {
        int prev = Integer.MAX_VALUE, n = prices.length, ans = 0;

        for (int i = 0; i < n; i++) {
            ans = Math.max(ans, prices[i] - prev);
            prev = Math.min(prev, prices[i]);
        }

        return ans;
    }
}
