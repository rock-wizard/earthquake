package leetcode;

class IsSubsequence {
    public boolean isSubsequence(String s, String t) {
        int len_s = s.length(), len_t = t.length();
        int i = 0, j = 0;

        while (i < len_s && j < len_t) {
            if (len_s - i > len_t - j) {
                return false;
            }

            if (s.charAt(i) == t.charAt(j)) {
                i++;
            }
            j++;
        }

        return i == len_s;
    }
}
