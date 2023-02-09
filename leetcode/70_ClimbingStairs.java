package leetcode;

class ClimbingStairs {
    public int climbStairs(int n) {
        if (n <= 2) {
            return n;
        }
        // prev1 means how many ways can reach the position that before current position
        // 1 step
        // prev2 means how many ways can reach the position that before current position
        // 2 step
        int prev1 = 2, prev2 = 1;

        for (int i = 3; i <= n; i++) {
            int temp = prev1 + prev2;
            prev2 = prev1;
            prev1 = temp;
        }

        return prev1;
    }
}
