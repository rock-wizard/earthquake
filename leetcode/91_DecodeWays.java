package leetcode;

class DecodeWays {
    public int numDecodings(String s) {
        return dfs(s, 0);
    }

    private int dfs(String s, int begin) {
        if (begin == s.length()) {
            return 1;
        }

        int ans = 0;
        StringBuilder curr = new StringBuilder();
        for (int i = begin; i < Math.min(begin + 2, s.length()); i++) {
            curr.append(s.charAt(i));
            if ((i > begin && s.charAt(i - 1) == '0') || Integer.parseInt(curr.toString()) < 1
                    || Integer.parseInt(curr.toString()) > 26) {
                return ans;
            }
            ans += dfs(s, i + 1);
        }
        return ans;
    }

    public int numDecodingsDP(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        dp[n] = 1;

        for (int i = n - 1; i >= 0; i--) {
            char c = s.charAt(i);
            if (c != '0') {
                dp[i] += dp[i + 1];
                if (i < n - 1 && (c == '1' || (c == '2' && s.charAt(i + 1) < '7'))) {
                    dp[i] += dp[i + 2];
                }
            }
        }

        return dp[0];
    }
}
