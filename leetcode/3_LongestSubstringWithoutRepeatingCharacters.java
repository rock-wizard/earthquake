package leetcode;

import java.util.HashMap;
import java.util.Map;

class LongestSubstringWithoutRpeatingCharacters {
    /*
     * We should use HashMap to judge if this character has been iterated.
     * We can use left and right variables to sign the two end of desired string
     * indices.
     * Whil we are iterating the string, if we find current character exists in the
     * HashMap, there are two cases:
     * case 1: previous character is in the left of left variable, nothing need to
     * do.
     * case 2: previous character is in the right of left variable, you should set
     * the left = index of previous character + 1.
     */
    public int lengthOfLongestSubstring(String s) {
        int ans = 0;
        HashMap<Character, Integer> map = new HashMap<>();

        for (int l = 0, r = 0; r < s.length(); r++) {
            if (map.containsKey(s.charAt(r))) {
                l = Math.max(map.get(s.charAt(r)) + 1, l);
            }
            map.put(s.charAt(r), r);
            ans = Math.max(ans, r - l + 1);
        }

        return ans;
    }

        public int lengthOfLongestSubstringNew(String s) {
        int ans = 0, l = 0;
        Map<Character, Integer> map = new HashMap<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (map.containsKey(c) && map.get(c) >= l) {
                l = map.get(c) + 1;
            }
            map.put(c, i);
            ans = Math.max(ans, i - l + 1);
        
        }

        return ans;
    }
}
