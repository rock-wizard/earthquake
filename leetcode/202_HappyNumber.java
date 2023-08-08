package leetcode;

import java.util.HashSet;
import java.util.Set;

class NumberOfIslands {
    public boolean isHappy(int n) {
        Set<Integer> set = new HashSet<>();
        while (set.add(n)) {
            int num = 0;

            while (n > 0) {
                int remainder = n % 10;
                num += remainder * remainder;
                n = n / 10;
            }

            if (num == 1) {
                return true;
            }

            n = num;
        }

        return false;
    }
}