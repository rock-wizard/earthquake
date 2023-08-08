package leetcode;

class LongestSubstringWithAtLeastKRepeatingCharacters {
    public int longestSubstring(String s, int k) {
        if (s == null || s.length() == 0) {
            return 0;
        }

        return helper(s, 0, s.length(), k);
    }

    private int helper(String s, int l, int r, int k) {
        if (l > r) {
            return 0;
        }

        int[] counter = new int[26];
        for (int i = l; i < r; i++) {
            counter[s.charAt(i) - 'a']++;
        }

        boolean isValid = true;
        for (int i = 0; i < 26; i++) {
            if (counter[i] > 0 && counter[i] < k) {
                isValid = false;
            }
        }
        if (isValid) {
            return r - l;
        }

        int ans = 0, begin = l;
        for (int i = l; i < r; i++) {
            if (counter[s.charAt(i) - 'a'] < k) {
                ans = Math.max(ans, helper(s, begin, i, k));
                begin = i + 1;
            }
        }
        ans = Math.max(ans, helper(s, begin, r, k));

        return ans;
    }
}
