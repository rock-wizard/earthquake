package leetcode;

class CountAndSay {
    public String countAndSay(int n) {
        String ans = "1";

        for (int i = 0; i < n - 1; i++) {
            StringBuilder newAns = new StringBuilder();
            for (int j = 0; j < ans.length(); j++) {
                int k = j;
                while (j + 1 < ans.length() && ans.charAt(j) == ans.charAt(j + 1)) {
                    j++;
                }
                newAns.append(j - k + 1);
                newAns.append(ans.charAt(k));
            }
            ans = newAns.toString();
        }
        return ans;
    }
}
