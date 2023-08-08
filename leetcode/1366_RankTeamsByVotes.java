package leetcode;

import java.util.Arrays;

class RankTeamsByVotes {
    public String rankTeams(String[] votes) {
        int m = votes.length, n = votes[0].length();
        int[][] dp = new int[26][n + 1];
        for (int i = 0; i < 26; i++) {
            dp[i][n] = i;
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                char c = votes[i].charAt(j);
                dp[c - 'A'][j]++;
            }
        }

        Arrays.sort(dp, (a, b) -> {
            for (int i = 0; i < n; i++) {
                if (a[i] < b[i]) {
                    return 1;
                } else if (a[i] > b[i]) {
                    return -1;
                }
            }
            return a[n] - b[n];
        });

        StringBuilder ans = new StringBuilder();
        for (int i = 0; i < n; i++) {
            ans.append((char) ('A' + dp[i][n]));
        }

        return ans.toString();
    }
}