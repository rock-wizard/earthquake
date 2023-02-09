package leetcode;

class LongestCommonPrefix {
    /*
     * horizontal scanning
     * 
     * To solve this problem, we can divide the big problem to several subproblems
     * as get commom prefix between two words repeatedly.
     * 
     * Step 1: We assume the current commom prefix is strs[0], so when we do
     * comparision should ignore it.
     * Step 2: We just use current common prefix to compare with next word to get
     * the common prefix.
     * Step 2: We then set the new common prefix as current common prefix and do
     * step 2 again and agin with other words
     * until there is no commom prefix or iterate all of words.
     * 
     */
    public String longestCommonPrefixHorizontalScanning(String[] strs) {
        if (strs == null || strs.length == 0) {
            return "";
        }

        StringBuilder ans = new StringBuilder(strs[0]);
        for (int i = 1; i < strs.length; i++) {
            StringBuilder commonPrefix = new StringBuilder();
            String s = strs[i];
            for (int j = 0; j < Math.min(s.length(), ans.length()); j++) {
                if (s.charAt(j) != ans.charAt(j)) {
                    break;
                }
                commonPrefix.append(s.charAt(j));
            }
            if (commonPrefix.length() == 0) {
                return "";
            }
            ans = commonPrefix;
        }
        return ans.toString();
    }

    /*
     * vertical scanning
     */
    public String longestCommonPrefixVerticalScanning(String[] strs) {
        if (strs == null || strs.length == 0) {
            return "";
        }

        StringBuilder ans = new StringBuilder();
        for (int i = 0; i < strs[0].length(); i++) {
            char c = strs[0].charAt(i);
            for (int j = 1; j < strs.length; j++) {
                if (strs[j].length() <= i || strs[j].charAt(i) != c) {
                    return ans.toString();
                }
            }
            ans.append(c);
        }
        return ans.toString();
    }

    /*
     * divide and conquer
     * 
     * We divide this big problem into several subproblems.
     * We use the divide and conquer technology, it splits the LCP(Si, Sj) into two subproblems LCP(Si, Smid) and LCP(Smid+1, j)
     * 
     * We assume the lcpLeft and lcpRight are the solutions of main problem LCP(Si, Sj).
     * So we just need to divide the LCP(Si,Sj) again and again until for each subproblem like LCP(Si,Si+1) or LCP(Si, Si) recursively.
     * and then we just need to conquer the easy subproblem to get common prefix with two words, 
     * after that we return the common prefix to the upper level.
     * 
     * To accomplish this we compare one by one the characters of lcpLeft and lcpRight till there is no character match.
     */
    public String longestCommonPrefixDivideAndConquer(String[] strs) {
        if (strs == null || strs.length == 0) {
            return "";
        }
        return Divide(strs, 0, strs.length - 1);
    }

    private String Divide(String[] strs, int l, int r) {
        if (l == r) {
            return strs[l];
        }

        int mid = (l + r) / 2;
        String left = Divide(strs, l, mid);
        String right = Divide(strs, mid + 1, r);
        return Conquer(left, right);
    }

    private String Conquer(String left, String right) {
        StringBuilder prefix = new StringBuilder();
        for (int i = 0; i < Math.min(left.length(), right.length()); i++) {
            if (left.charAt(i) != right.charAt(i)) {
                break;
            }
            prefix.append(left.charAt(i));
        }
        return prefix.toString();
    }
}