package leetcode;

class LongestPalindrome {
    public int longestPalindrome(String s) {
        int[] counter = new int[58];
        int ans = 0;

        for (char c : s.toCharArray()) {
            counter[c - 'A']++;
        }

        for (int i = 0; i < 58; i++) {
            ans += counter[i] / 2 * 2;
            if (counter[i] % 2 == 1 && ans % 2 == 0) {
                ans++;
            }
        }

        return ans;
    }
}
