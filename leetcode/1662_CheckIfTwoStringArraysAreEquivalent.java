package leetcode;

class CheckIfTwoStringArraysAreEquivalent {
    public boolean arrayStringsAreEqual(String[] word1, String[] word2) {
        int i = 0, j = 0;
        int ii = 0, jj = 0;
        int m = word1.length, n = word2.length;
        String s1 = null, s2 = null;

        while (i < m && j < n) {
            s1 = word1[i];
            s2 = word2[j];

            if (s1.charAt(ii++) != s2.charAt(jj++)) {
                return false;
            }

            if (ii == s1.length()) {
                i++;
                ii = 0;
            }

            if (jj == s2.length()) {
                j++;
                jj = 0;
            }
        }
        return i == m && j == n;
    }
}
