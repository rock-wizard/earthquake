package leetcode;

import java.util.Stack;

class BasicCalculatorII {
    public int calculate(String s) {
        if (s == null || s.length() == 0) {
            return 0;
        }

        Stack<Integer> stack = new Stack<>();
        int curr = 0;
        int ans = 0;
        char operator = '+';
        s += '!';

        for (Character c : s.toCharArray()) {
            if (c == ' ') {
                continue;
            }

            if (c >= '0' && c <= '9') {
                curr = curr * 10 + (c - '0');
            } else {
                if (operator == '*' || operator == '/') {
                    stack.push(evaluate(operator, stack.pop(), curr));
                } else {
                    stack.push(evaluate(operator, curr, 0));
                }
                curr = 0;
                operator = c;
            }
        }

        for (int num : stack) {
            ans += num;
        }

        return ans;
    }

    private int evaluate(char operator, int x, int y) {
        if (operator == '+') {
            return x;
        } else if (operator == '-') {
            return -x;
        } else if (operator == '*') {
            return x * y;
        }
        return x / y;
    }
}
