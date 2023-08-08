package leetcode;

import java.util.Stack;

class ScoreOfParentheses {
    public int scoreOfParentheses(String s) {
        Stack<Integer> stack = new Stack<>();
        stack.push(0);

        for (Character c : s.toCharArray()) {
            if (c == '(') {
                stack.push(0);
            } else {
                int prev = stack.pop();
                int curr = stack.pop();
                stack.push(curr + Math.max(2 * prev, 1));
            }
        }

        return stack.pop();
    }

     public int scoreOfParenthesesBetter(String s) {
       return dfs(s, 0, s.length());
    }

    private int dfs(String s, int l, int r) {
        int curr = 0, balance = 0;
        for (int i = l; i < r; i++) {
            char c = s.charAt(i);
            
            balance += c == '(' ? 1 : -1;
            if (balance == 0) {
                if (i - l == 1) {
                    curr++;
                } else {
                    curr += 2 * dfs(s, l + 1, i);
                }
                l = i + 1;
            }
        }
        
        return curr;
    }
}
