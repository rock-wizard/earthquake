package algorithm.sliding_window;

import java.util.HashMap;
import java.util.Map;

class MinimumWindowSubstring {
    public String minWindow(String s, String t) {
        int m = s.length();
        Map<Character, Integer> sMap = new HashMap<>();
        Map<Character, Integer> tMap = new HashMap<>();
        for (char c : t.toCharArray()) {
            tMap.put(c, tMap.getOrDefault(c, 0) + 1);
        }

        int[] ans = { -1, 0, 0 };
        int required = tMap.size(), satisfied = 0;
        int l = 0;
        for (int r = 0; r < m; r++) {
            char c = s.charAt(r);
            // if (!tMap.containsKey(c)) continue;
            sMap.put(c, sMap.getOrDefault(c, 0) + 1);

            if (tMap.containsKey(c) && sMap.get(c).intValue() == tMap.get(c).intValue()) {
                satisfied++;
            }

            while (l <= r && satisfied == required) {
                c = s.charAt(l);
                if (tMap.containsKey(c) && sMap.get(c) - 1 < tMap.get(c)) {
                    if (ans[0] == -1 || ans[0] > r - l + 1) {
                        ans[0] = r - l + 1;
                        ans[1] = l;
                        ans[2] = r;
                    }
                    satisfied--;
                }
                sMap.replace(c, sMap.get(c) - 1);
                l++;
            }

        }
        return ans[0] == -1 ? "" : s.substring(ans[1], ans[2] + 1);
    }

    public String minWindowByMySelf(String s, String t) {
        String ans = "";
        int m = s.length(), n = t.length();
        Map<Character, Integer> sMap = new HashMap<>();
        Map<Character, Integer> tMap = new HashMap<>();
        for (char c : t.toCharArray()) {
            tMap.put(c, tMap.getOrDefault(c, 0) + 1);
        }

        int l = 0;
        for (int r = 0; r < m; r++) {
            if (m - l + 1 < n) {
                break;
            }
            sMap.put(s.charAt(r), sMap.getOrDefault(s.charAt(r), 0) + 1);
            if (!isMatch(sMap, tMap)) {
                continue;
            }

            while (l < r) {
                char c = s.charAt(l);
                if (tMap.containsKey(c) && sMap.get(c) - 1 < tMap.get(c)) {
                    break;
                }
                l++;
                sMap.replace(c, sMap.get(c) - 1);
            }

            ans = r - l + 1 < ans.length() || ans.equals("") ? s.substring(l, r + 1) : ans;
            sMap.replace(s.charAt(l), sMap.get(s.charAt(l)) - 1);
            l++;
        }
        return ans;
    }

    private boolean isMatch(Map<Character, Integer> s, Map<Character, Integer> t) {
        if (s.size() < t.size()) {
            return false;
        }
        for (Map.Entry<Character, Integer> entry : t.entrySet()) {
            if (!s.containsKey(entry.getKey())) {
                return false;
            }
            if (s.get(entry.getKey()) < entry.getValue()) {
                return false;
            }
        }
        return true;
    }

    public String minWindowBetter(String s, String t) {
        Map<Character, Integer> target = new HashMap<>();
        Map<Character, Integer> window = new HashMap<>();

        for (char c : t.toCharArray()) {
            target.put(c, target.getOrDefault(c, 0) + 1);
        }

        int start = 0, len = Integer.MAX_VALUE;
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

            while (valid == target.size()) {
                if (r - l < len) {
                    start = l;
                    len = r - l;
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

        return len == Integer.MAX_VALUE ? "" : s.substring(start, start + len);
    }
}
