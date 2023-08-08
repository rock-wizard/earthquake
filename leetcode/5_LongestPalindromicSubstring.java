package leetcode;

class LongestPalindromicSubstring {
    /*
     * there are three cases in start-up periord:
     * case 1: **a**
     * case 2: **aa**
     * case 3: **aaa**
     * 
     * So we use the array to store which sub string is palindromic,
     * if the string is less than or equal to 3, we don't need to use array to judge
     * it.
     * for each dp, we should judge if it's the palindromic, if it's, we should to
     * compare the length to get the longest one.
     * 
     */
    public String longestPalindromeByDp(String s) {
        String ans = null;
        int n = s.length();
        boolean[][] dp = new boolean[n][n];

        for (int r = 0; r < n; r++) {
            for (int l = r; l >= 0; l--) {
                dp[l][r] = s.charAt(l) == s.charAt(r) && (r - l < 3 || dp[l + 1][r - 1]);

                if (dp[l][r] && (ans == null || r - l + 1 > ans.length())) {
                    ans = s.substring(l, r + 1);
                }
            }
        }
        return ans;
    }

    /*
     * Iterate the string and make each character as the middle of a string, and from it to left the find all of same characters.
     * After that, seem it as a whole, and use left and right to determine if this string is palindrome.
     */
    public String longestPalindrome(String s) {
        String ans = "";
        int n = s.length();

        for (int i = 0; i < n; i++) {
            int l = i - 1;
            int r = i + 1;

            while (l >= 0 && s.charAt(l) == s.charAt(i)) {
                l--;
            }

            while (l >= 0 && r < n && s.charAt(l) == s.charAt(r)) {
                l--;
                r++;
            }

            if (r - l - 1 > ans.length()) {
                ans = s.substring(l + 1, r);
            }
        }

        return ans;
    }

    public static void main(String[] args) {
        boolean[][] bbb = new boolean[10][10];
        for (int i =0;i<10;i++){
            for (int j = 0;j<10;j++){
                System.out.println(bbb[i][j]);
            }
        }
    }
}
