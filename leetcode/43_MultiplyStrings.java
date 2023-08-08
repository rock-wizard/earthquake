package leetcode;

/**
 * https://leetcode.com/problems/multiply-strings/solutions/17605/easiest-java-solution-with-graph-explanation/
 */

class MultiplyStrings {
    public String multiply(String num1, String num2) {
        int m = num1.length(), n = num2.length();
        int[] nums = new int[m + n];

        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                int n1 = num1.charAt(i) - '0', n2 = num2.charAt(j) - '0';
                int p1 = i + j, p2 = i + j + 1;

                int sum = n1 * n2 + nums[p2];
                nums[p1] += sum / 10;
                nums[p2] = sum % 10;
            }
        }

        StringBuilder ans = new StringBuilder();
        for (int i = 0; i < nums.length; i++) {
            if (ans.length() == 0 && nums[i] == 0) {
                continue;
            }
            ans.append(nums[i]);
        }

        return ans.length() == 0 ? "0" : ans.toString();
    }
}
