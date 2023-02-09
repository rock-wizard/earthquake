package leetcode;

import java.util.ArrayList;
import java.util.List;

/*
 * Deep Search
 * Declare a String array, use the index to represent the phone number, the value of index represents the characters.
 */

class LetterCombinationsOfAPhoneNumber {
    public List<String> letterCombinations(String digits) {
        if (digits == null || digits.length() == 0) {
            return new ArrayList();
        }

        String[] dict = new String[] {
            "", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"
        };

        List<String> ans = new ArrayList<>();
        recusion(digits, dict, ans, new StringBuilder(), 0);
        return ans;
    }

    private void recusion(String digits, String[] dict, List<String> ans, StringBuilder path, int index) {
        if (index == digits.length()) {
            ans.add(path.toString());
            return;
        }
        String s = dict[digits.charAt(index) - '0'];
        for (int i = 0; i < s.length(); i++) {
            path.append(s.charAt(i));
            recusion(digits, dict, ans, path, index + 1);
            path.deleteCharAt(index);
        }
    }

}
