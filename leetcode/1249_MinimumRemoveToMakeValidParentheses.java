package leetcode;

import java.util.HashSet;
import java.util.Set;
import java.util.Stack;

class MinimumRemoveToMakeValidParentheses {
    public String minRemoveToMakeValid(String s) {
        StringBuilder ans = new StringBuilder();
        Stack<Integer> stack = new Stack<>();
        Set<Integer> removes = new HashSet<>();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '(') {
                stack.push(i);
            } else if (c == ')') {
                if (stack.empty()) {
                    removes.add(i);
                } else {
                    stack.pop();
                }
            }
        }

        // clean the stack
        while (!stack.empty()) {
            removes.add(stack.pop());
        }

        for (int i = 0; i < s.length(); i++) {
            if (!removes.contains(i)) {
                ans.append(s.charAt(i));
            }
        }
        return ans.toString();
    }
}
