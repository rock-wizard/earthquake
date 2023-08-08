package leetcode;

class StringToInteger {
    public static void main(String[] args) {
        StringToInteger ins = new StringToInteger();
        System.out.println(ins.myAtoi("4193 with words"));
        System.out.println(Integer.MAX_VALUE);
    }

    public int myAtoi(String s) {
        int ans = 0, i = 0, sign = 1;

        if (s.length() == 0) {
            return 0;
        }

        // filter the space
        while (i < s.length() && s.charAt(i) == ' ') {
            i++;
        }

        // find the sign
        if (i < s.length() && (s.charAt(i) == '+' || s.charAt(i) == '-')) {
            sign = s.charAt(i) == '+' ? 1 : -1;
            i++;
        }

        while (i < s.length()) {
            if (s.charAt(i) < '0' || s.charAt(i) > '9') {
                break;
            }
            int added = s.charAt(i) - '0';
            if (sign == 1 && ans > (Integer.MAX_VALUE - added) / 10) {
                return Integer.MAX_VALUE;
            }
            if (sign == -1 && -ans < (Integer.MIN_VALUE + added) / 10) {
                return Integer.MIN_VALUE;
            }
            ans = ans * 10 + added;
            i++;
        }
        return ans * sign;
    }
}
