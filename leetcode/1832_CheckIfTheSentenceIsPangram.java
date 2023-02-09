package leetcode;

import java.util.HashSet;
import java.util.Set;

class CheckIfTheSentenceIsPangram {
    public boolean checkIfPangramBinary(String sentence) {
        int ans = 0;
        for (char c : sentence.toCharArray()) {
            ans |= 1 << (c - 'a');
        }

        return ans == (1 << 26) - 1;
    }

    public boolean checkIfPangramBooleanArray(String sentence) {
        boolean[] ans = new boolean[26];
        for (char c : sentence.toCharArray()) {
            ans[c - 'a'] = true;
        }

        for (int i = 0; i < ans.length; i++) {
            if (!ans[i]) {
                return false;
            }
        }
        return true;
    }

    public boolean checkIfPangramSet(String sentence) {
        Set<Character> ans = new HashSet<Character>();

        for (char c : sentence.toCharArray()) {
            ans.add(c);
        }

        return ans.size() == 26;
    }

    public boolean checkIfPangramIndexOf(String sentence) {
        for (int i = 0; i < 26; i++) {
            char c = (char) ('a' + i);
            if (sentence.indexOf(c) == -1) {
                return false;
            }
        } 
        return true;
    }
}
