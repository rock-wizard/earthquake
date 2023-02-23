package algorithm.sliding_window;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class FindAllAnagramsinaString {
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> ans = new ArrayList<>();
        Map<Character, Integer> target = new HashMap<>();
        Map<Character, Integer> window = new HashMap<>();

        for (char c : p.toCharArray()) {
            target.put(c, target.getOrDefault(c, 0) + 1);
        }

        int l = 0, r = 0;
        int valid = 0;

        while (r < s.length()) {
            char c = s.charAt(r++);

            if (target.containsKey(c)) {
                window.put(c, window.getOrDefault(c, 0) + 1);
                if (window.get(c).equals(target.get(c))) {
                    valid++;
                }
            }

            if (r - l == p.length()) {
                if (valid == target.size()) {
                    ans.add(l);
                }

                c = s.charAt(l++);
                if (target.containsKey(c)) {
                    if (window.get(c).equals(target.get(c))) {
                        valid--;
                    }
                    window.put(c, window.get(c) - 1);
                }
            }
        }

        return ans;
    }
}
