package leetcode;

import java.util.ArrayList;
import java.util.List;

class RestoreIPAddresses {
    public List<String> restoreIpAddresses(String s) {
        List<String> ans = new ArrayList<>();
        dfs(s, ans, new ArrayList<String>(), 0);
        return ans;
    }

    private void dfs(String s, List<String> ans, List<String> path, int pos) {
        if (path.size() == 4) {
            if (pos == s.length()) {
                ans.add(String.join(".", path));
            }
            return;
        }

        for (int i = pos; i < Math.min(s.length(), pos + 3); i++) {
            String sub = s.substring(pos, i + 1);
            if (isVaild(sub)) {
                path.add(sub);
                dfs(s, ans, path, i + 1);
                path.remove(path.size() - 1);
            }
        }
    }

    private boolean isVaild(String s) {
        if (s.length() > 1 && s.charAt(0) == '0') {
            return false;
        }

        int num = Integer.parseInt(s);
        return num >= 0 && num <= 255;
    }
}
