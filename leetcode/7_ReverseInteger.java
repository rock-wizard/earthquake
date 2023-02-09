package leetcode;

class ReverseInteger {
    public static void main(String[] args) {
        ReverseInteger ins = new ReverseInteger();
        System.out.print(ins.reverse(-321));
    }

    /*
     * we can get the number at the end of this number through remainder of divition,
     * and get rid of the latesr number through divition. 
     * ans = ans * 10 + num % 10
     * num = num / 10
     * 
     * the most important thing is to judge the boundaries of int32.
     * if x > 0:
     *      ans * 10 + remained > MAX
     * if x < 0:
     *      ans * 10 + remained < MIN
     * 
     * Note: The remainder of a negative number is also a negative number.
     * 
     */
    public int reverse(int x) {
        int ans = 0;

        while (x != 0) {
            int remainder = x % 10;
            if (x > 0 && ans > (Integer.MAX_VALUE - remainder) / 10) {
                return 0;
            }
            if (x < 0 && ans < (Integer.MIN_VALUE - remainder) / 10) {
                return 0;
            }
            x /= 10;
            ans = ans * 10 + remainder;
        }
        return ans;
    }
}
