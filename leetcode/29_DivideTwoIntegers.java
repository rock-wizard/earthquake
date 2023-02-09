package leetcode;

class DivideTwoIntegers {
    public int divide(int dividend, int divisor) {
        long dividendL = Math.abs((long) dividend);
        long divisorL = Math.abs((long) divisor);
        int isPositive = dividend > 0 ^ divisor > 0 ? -1 : 1;

        long ans = 0;
        long base = 1;
        while (divisorL <= dividendL) {
            int x = 0;
            while ((divisorL << (x + 1)) <= dividendL) {
                x++;
            }
            ans += base << x;
            dividendL -= divisorL << x;
        }

        System.out.println(ans);
        ans = ans * isPositive;
        System.out.println(ans);
        System.out.println(isPositive);

        if (ans >= Integer.MAX_VALUE) {
            return Integer.MAX_VALUE;
        }
        if (ans <= Integer.MIN_VALUE) {
            return Integer.MIN_VALUE;
        }

        return (int) ans;
    }

    public static void main(String[] args) {
        DivideTwoIntegers ins = new DivideTwoIntegers();
        System.out.println(ins.divide(-2147483648, -1));
        ins.xxx();
    }

    private void xxx() {
        int x = 10;
        System.out.println(x);
    }
}
