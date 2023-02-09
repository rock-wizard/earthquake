package leetcode;

import java.util.HashMap;
import java.util.Map;

class RomanToInteger {
    public int romanToInt(String s) {
        Map<Character, Integer> romanDict = new HashMap<Character, Integer>(

        // Map.of(
        // 'M', 1000,
        // 'D', 500,
        // 'C', 100,
        // 'L', 50,
        // 'X', 10,
        // 'V', 5,
        // 'I', 1
        // )
        );
        romanDict.put('M', 1000);
        romanDict.put('D', 500);
        romanDict.put('C', 100);
        romanDict.put('L', 50);
        romanDict.put('X', 10);
        romanDict.put('V', 5);
        romanDict.put('I', 1);

        int ans = 0;
        for (int i = 0; i < s.length(); i++) {
            char curr = s.charAt(i);
            char next = i + 1 < s.length() ? s.charAt(i + 1) : ' ';
            if (next != ' ' && romanDict.get(next) > romanDict.get(curr)) {
                ans -= romanDict.get(curr);
            } else {
                ans += romanDict.get(curr);
            }
        }
        return ans;
    }
}
