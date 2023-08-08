package leetcode;

import java.util.HashMap;
import java.util.Map;

class LongestPalindromeByConcatenatingTwoLetterWords {
    public int longestPalindrome(String[] words) {
        Map<String, Integer> map = new HashMap<>();
        for (String word : words) {
            map.put(word, map.getOrDefault(word, 0) + 1);
        }

        int ans = 0;
        boolean flag = false;
        for (String word : map.keySet()) {
            String reversed = new StringBuilder().append(word.charAt(1)).append(word.charAt(0)).toString();
            
            /**
             * if multiple same lettes appear more than twice, only one can use all of them
             */
            if (word.equals(reversed)) {
                int cnt = map.get(word);
                ans += 4 * (cnt / 2);

                if (cnt % 2 == 1 && !flag) {
                    ans += 2;
                    flag = true;
                }
            } else {
                if (map.containsKey(reversed) && map.get(reversed) > 0) {
                    int cnt = Math.min(map.get(word), map.get(reversed));
                    ans += 4 * cnt;
                    map.put(word, 0);
                    map.put(reversed, 0);
                }
            }
        }

        return ans;
    }
}
