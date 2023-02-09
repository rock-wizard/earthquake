package leetcode;

class RegularExpressionMatching {
    /*
     * s is the text, p is the pattern
     * The wildcard must depend on the character in front of it.
     * So when we meet the wildcard, there are some cases:
     * 1. we need to use * to math next character in the text
     * 2. we may ignore * to make it means zero.
     * 
     * The normal match process just need to match if the character of text is equal
     * the character of pattern.
     * 
     */
    public boolean isMatchRecursion(String s, String p) {
        // It's easy to find the end condition if the pattern is empyt,
        // because no pattern to match the text, so the value depends on the if the text
        // is also empty.
        // But is text is empty, the pattern may be the .* and the * means zero, it's
        // difficult to determine.
        if (p.isEmpty()) {
            return s.isEmpty();
        }

        // to judge whether the first character of text is same to the first character
        // of pattern.
        boolean firstMatch = !s.isEmpty() && (s.charAt(0) == p.charAt(0) || p.charAt(0) == '.');
        if (p.length() >= 2 && p.charAt(1) == '*') {
            return isMatchRecursion(s, p.substring(2)) || (firstMatch && isMatchRecursion(s.substring(1), p));
        } else {
            return firstMatch && isMatchRecursion(s.substring(1), p.substring(1));
        }
    }

    public boolean isMatchWithRecord(String s, String p) {
        boolean[][] dp = new boolean[s.length() + 1][p.length() + 1];
        boolean[][] visited = new boolean[s.length() + 1][p.length() + 1];
        return isMattchWithRecordRecursion(0, 0, s, p, dp, visited);
    }

    public boolean isMattchWithRecordRecursion(int i, int j, String s, String p, boolean[][] dp, boolean[][] visited) {
        if (visited[i][j]) {
            return dp[i][j];
        }

        if (j == p.length()) {
            dp[i][j] = i == s.length();
        } else {
            boolean firstMatch = i < s.length() && (s.charAt(i) == p.charAt(j) || p.charAt(j) == '.');
            if (j + 1 < p.length() && p.charAt(j + 1) == '*') {
                dp[i][j] = isMattchWithRecordRecursion(i, j + 2, s, p, dp, visited)
                        || (firstMatch && isMattchWithRecordRecursion(i + 1, j, s, p, dp, visited));
            } else {
                dp[i][j] = firstMatch && isMattchWithRecordRecursion(i + 1, j + 1, s, p, dp, visited);
            }
        }
        visited[i][j] = true;
        return dp[i][j];
    }

    /*
     * Assume dp[i][j] means whether i characters of text(s[0:i-1]) matchs j characters of pattern(p[0:j-1]).
     * We consider the basic cases firstly:
     *      case1: p == null && s == null -> must match -> true
     *      case2: p == null && s != null -> must not match -> false
     *      case3: p != null && s == null -> if they wanna match, the p must like x*x*x*x*x*
     * 
     * Considering normal cases:
     *      case1: p[j-1] != s[j-1] && p[j-1] != '.' && p[j-1] != * -> 
     *             it must false -> nothing to do, coz default val is false
     * 
     *      case2: p[j-1] == s[i-1] || s[i-1] == '.' ->
     *             we should determine whether left part is matched -> dp[i][j] = dp[i-1][j-1]
     *      case3: p[j-1] == '*':
     *          if p[j-2] == s[i-1] || p[j-2] == '.':
     *          case3.1:
     *              * make p[j-2] appear 0 time ->
     *              we should judge s[i-1] == p[j-3] -> dp[i][j] = dp[i][j-2]
     *          case3.2:
     *              * make p[j-2] appear 1 time ->
     *              we should judge s[i-2] == p[j-3] -> dp[i][j] = dp[i-1][j-2]
     *          case3.3:
     *              * make p[j-2] apear more than 1 time ->
     *              we should judge s[i-2] == p[j-1] -> coz we jsut delete this character from text and pattern
     *          if p[j-2] != s[i-1] && p[j-2] != '.':
     *              The * must make p[j-2] appear 0 time, beacause they don't match ->
     *              we should judge s[i-1] == p[j-3] -> dp[i][j] = dp[i][j-2]
     * 
     */
    public boolean isMatchWithDp(String s, String p) {
        if (p.isEmpty()) {
            return s.isEmpty();
        }

        int m = s.length(), n = p.length();
        boolean[][] dp = new boolean[m + 1][n + 1];
        dp[0][0] = true;

        for (int j = 1; j <= n; j++) {
            if (p.charAt(j - 1) == '*') {
                dp[0][j] = dp[0][j - 2];
            }
        }

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (s.charAt(i - 1) == p.charAt(j - 1) || p.charAt(j - 1) == '.') {
                    dp[i][j] = dp[i - 1][j - 1];
                } else if (p.charAt(j - 1) == '*') {
                    if (s.charAt(i - 1) == p.charAt(j - 2) || p.charAt(j - 2) == '.') {
                        dp[i][j] = dp[i][j - 2] || dp[i - 1][j - 2] || dp[i - 1][j];
                    } else {
                        dp[i][j] = dp[i][j - 2];
                    }
                }
            }
        }
        return dp[m][n];
    }
}
