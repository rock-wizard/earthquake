package leetcode;

class FibonacciNumber {
    public int fib(int n) {
        if (n < 2) {
            return n;
        }

        int a = 0, b = 1;
        for (int i = 2; i <= n; i++) {
            int temp = a + b;
            a = b;
            b = temp;
        }

        return b;
    }

    public int fibDfs(int n) {
        if (n < 2) {
            return n;
        }

        return fib(n - 2) + fib(n - 1);
    }
}
