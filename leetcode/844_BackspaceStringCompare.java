package leetcode;

class BackspaceStringCompare {
    public boolean backspaceCompare(String s, String t) {
        StringBuilder sb_s = new StringBuilder();
        StringBuilder sb_t = new StringBuilder();

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (c == '#') {
                if (sb_s.length() > 0) {
                    sb_s.deleteCharAt(sb_s.length() - 1);
                }
            } else {
                sb_s.append(c);
            }
        }

        for (int i = 0; i < t.length(); i++) {
            char c = t.charAt(i);
            if (c == '#') {
                if (sb_t.length() > 0) {
                    sb_t.deleteCharAt(sb_t.length() - 1);
                }
            } else {
                sb_t.append(c);
            }
        }

        return sb_s.toString().equals(sb_t.toString());
    }
}
