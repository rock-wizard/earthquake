package leetcode;

import java.util.Stack;

class DecodeString {
    public String decodeString(String s) {
        if (s == null || s.length() == 0) {
            return "";
        }

        Stack<Integer> numStack = new Stack<>();
        Stack<String> strStack = new Stack<>();
        int num = 0;
        StringBuilder str = new StringBuilder();

        for (Character c : s.toCharArray()) {
            if (c >= '0' && c <= '9') {
                num = num * 10 + c - '0';
            } else if (c >= 'a' && c <= 'z') {
                str.append(c);
            } else if (c == '[') {
                numStack.push(num);
                num = 0;

                strStack.push(str.toString());
                str = new StringBuilder();
            } else {
                StringBuilder base = new StringBuilder(strStack.pop());
                base.append(str.toString().repeat(numStack.pop()));
                str = base;
            }   
        }

        return str.toString();
    }
}
