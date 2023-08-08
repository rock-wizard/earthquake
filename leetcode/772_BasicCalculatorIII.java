package leetcode;

import java.util.Stack;

class BasicCalculatorIII {
    public int calculate(String s) {
        if (s == null || s.length() == 0) {
            return 0;
        }

        int ans = 0;
        Stack<String> stack = new Stack<>();
        StringBuilder curr = new StringBuilder();
        s += "!";
        char operator = '+';

        for (Character c : s.toCharArray()) {
            if (c == ' ') {
                continue;
            }

            if (c >= '0' && c <= '9') {
                curr.append(c);
            } else if (c == '(') {
                stack.push(Character.toString(operator));
                // reset the initialised operator within ();
                operator = '+';
            } else {
                if (operator == '*' || operator == '/') {
                    stack.push(evaluate(operator, stack.pop(), curr.toString()));
                } else {
                    stack.push(evaluate(operator, curr.toString(), "0"));
                }
                curr = new StringBuilder();
                operator = c;

                if (c == ')') {
                    int temp = 0;
                    while (!stack.peek().equals("+") && !stack.peek().equals("-") && !stack.peek().equals("*")
                            && !stack.peek().equals("/")) {
                        System.out.println(stack.peek());
                        temp += Integer.parseInt(stack.pop());
                    }
                    curr = new StringBuilder(Integer.toString(temp));
                    operator = stack.pop().charAt(0);
                }
            }
        }

        for (String num : stack) {
            ans += Integer.parseInt(num);
        }

        return ans;
    }

    private String evaluate(char operator, String a, String b) {
        int x = Integer.parseInt(a);
        int y = Integer.parseInt(b);
        int res = 0;

        if (operator == '+') {
            res = x;
        } else if (operator == '-') {
            res = -x;
        } else if (operator == '*') {
            res = x * y;
        } else {
            res = x / y;
        }

        return Integer.toString(res);
    }
}
