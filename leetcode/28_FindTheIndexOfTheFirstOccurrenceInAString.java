package leetcode;

// TODO KMP

class FindTheIndexOfTheFirstOccurrenceInAString {
    public int strStr(String haystack, String needle) {
        int m = haystack.length(), n = needle.length();

        for (int i = 0; i <= m - n; i++) {
            int l = i, r = 0;
            while (r < n && haystack.charAt(l) == needle.charAt(r)) {
                l++;
                r++;
            }
            if (r == n) {
                return i;
            }
        }

        return -1;
    }    
}
