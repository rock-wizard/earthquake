package leetcode;

import java.util.Stack;

class DecodeString {
    public String decodeString(String s) {
        Stack<Integer> s_num = new Stack<>();
        Stack<StringBuilder> s_str = new Stack<>();
        StringBuilder str = new StringBuilder();
        int num = 0;

        for (char c : s.toCharArray()) {
            if (c >= '0' && c <= '9') {
                num = num * 10 + c - '0';
            } else if (c == '[') {
                s_str.push(str);
                str = new StringBuilder();

                s_num.push(num);
                num = 0;
            } else if (c == ']') {
                StringBuilder temp = new StringBuilder(s_str.pop());
                int count = s_num.pop();
                for (int j = 0; j < count; j++) {
                    temp.append(str);
                }
                str = temp;
            } else {
                str.append(c);
            }
        }
        return str.toString();

    }
}
