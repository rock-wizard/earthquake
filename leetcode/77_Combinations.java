package leetcode;

import java.util.ArrayList;
import java.util.List;

class Combinations {
    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> ans = new ArrayList<>();
        List<Integer> path = new ArrayList<>();

        dfs(ans, path, n, k, 1);

        return ans;
    }

    private void dfs(List<List<Integer>> ans, List<Integer> path, int n, int k, int begin) {
        if (path.size() == k) {
            ans.add(new ArrayList(path));
            return;
        }

        for (int i = begin; i <= n; i++) {
            path.add(i);
            dfs(ans, path, n, k, i + 1);
            path.remove(path.size() - 1);
        }
    }

}
