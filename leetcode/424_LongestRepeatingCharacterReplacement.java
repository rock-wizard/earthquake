package leetcode;

class LongestRepeatingCharacterReplacement {
    public int characterReplacement(String s, int k) {
        int ans = 0;
        int l = 0, r = 0, curr_max = 0;
        boolean valid = false;
        int[] window = new int[26];


        while (r < s.length()) {
            char c = s.charAt(r++);
            window[c - 'A']++;
            curr_max = Math.max(curr_max, window[c - 'A']);

            if (r - l - curr_max > k) {
                c = s.charAt(l++);
                window[c - 'A']--;
            }

            ans = Math.max(ans, r - l);
        }

        return ans;
    }
}
