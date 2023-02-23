package leetcode;

import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

class PermutationInString {
    public boolean checkInclusion(String s1, String s2) {
        Map<Character, Integer> cnt_s1 = new HashMap<>();
        Map<Character, Integer> cnt_s2 = new HashMap<>();

        for (char c : s1.toCharArray()) {
            cnt_s1.put(c, cnt_s1.getOrDefault(c, 0) + 1);
        }

        int l = 0, r = 0;
        int valid = 0;

        while (r < s2.length()) {
            char c = s2.charAt(r++);

            if (cnt_s1.containsKey(c)) {
                cnt_s2.put(c, cnt_s2.getOrDefault(c, 0) + 1);
                if (cnt_s2.get(c).equals(cnt_s1.get(c))) {
                    valid++;
                }
            }

            if (r - l == s1.length()) {
                if (valid == cnt_s1.size()) {
                    return true;
                }

                c = s2.charAt(l++);
                if (cnt_s1.containsKey(c)) {
                    if (cnt_s2.get(c).equals(cnt_s1.get(c))) {
                        valid--;
                    }
                    cnt_s2.put(c, cnt_s2.get(c) - 1);
                }
            }
        }

        return false;
    }

    public boolean backspaceCompareStack(String s, String t) {
        Stack<Character> s_s = new Stack<>();
        Stack<Character> s_t = new Stack<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c != '#') {
                s_s.push(c);
            } else if (!s_s.empty()) {
                s_s.pop();
            }
        }

        for (int i = 0; i < t.length(); i++) {
            char c = t.charAt(i);
            if (c != '#') {
                s_t.push(c);
            } else if (!s_t.empty()) {
                s_t.pop();
            }
        }

        return String.valueOf(s_s).equals(String.valueOf(s_t));
    }

    public boolean backspaceCompare(String s, String t) {
        int i = s.length() - 1, j = t.length() - 1;
        int skip_i = 0, skip_j = 0;

        while (i >= 0 || j >= 0) {
            while (i >= 0) {
                if (s.charAt(i) == '#') {
                    i--;
                    skip_i++;
                } else if (skip_i > 0) {
                    i--;
                    skip_i--;
                } else {
                    break;
                }
            }

            while (j >= 0) {
                if (t.charAt(j) == '#') {
                    j--;
                    skip_j++;
                } else if (skip_j > 0) {
                    j--;
                    skip_j--;
                } else {
                    break;
                }
            }

            if (i < 0 ^ j < 0) {
                return false;
            }

            if (i >= 0 && j >= 0 && s.charAt(i) != t.charAt(j)) {
                return false;
            }
            i--;
            j--;
        }
        return true;
    }

    public String decodeString(String s) {
        Stack<Integer> numStack = new Stack<>();
        Stack<StringBuilder> strBuild = new Stack<>();
        StringBuilder str = new StringBuilder();
        int num = 0;
        for (char c : s.toCharArray()) {
            if (c >= '0' && c <= '9') {
                num = num * 10 + c - '0';
            } else if (c == '[') {
                strBuild.push(str);
                str = new StringBuilder();
                numStack.push(num);
                num = 0;
            } else if (c == ']') {
                StringBuilder temp = str;
                str = strBuild.pop();
                int count = numStack.pop();
                while (count-- > 0) {
                    str.append(temp);
                }
            } else {
                str.append(c);
            }
        }
        return str.toString();

    }
}