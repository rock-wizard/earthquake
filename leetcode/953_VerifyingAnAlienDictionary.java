package leetcode;

class VerifyingAnAlienDictionary {
    public boolean isAlienSorted(String[] words, String order) {
        int[] alpha = new int[26];
        for (int i = 0; i < order.length(); i++) {
            alpha[order.charAt(i) - 'a'] = i;
        }

        for (int i = 1; i < words.length; i++) {
            String s1 = words[i - 1];
            String s2 = words[i];

            boolean flag = true;
            for (int j = 0; j < Math.min(s1.length(), s2.length()); j++) {
                if (alpha[s1.charAt(j) - 'a'] < alpha[s2.charAt(j) - 'a']) {
                    flag = false;
                    break;
                } else if (alpha[s1.charAt(j) - 'a'] > alpha[s2.charAt(j) - 'a']) {
                    return false;
                }
            }

            if (flag && s1.length() > s2.length()) {
                return false;
            }
        }

        return true;
    }
}
