package leetcode;

import java.util.ArrayList;
import java.util.List;

class CombinationSumIII {
    public List<List<Integer>> combinationSum3(int k, int n) {
        List<List<Integer>> ans = new ArrayList<>();
        List<Integer> path = new ArrayList<>();
        dfs(ans, path, k, n, 1);
        return ans;
    }

    private void dfs(List<List<Integer>> ans, List<Integer> path, int k, int n, int begin) {
        if (k == 0) {
            if (n == 0) {
                ans.add(new ArrayList<Integer>(path));
            }
            return;
        }

        for (int i = begin; i < 10; i++) {
            if (i > n) {
                return;
            }

            path.add(i);
            dfs(ans, path, k - 1, n - i, i + 1);
            path.remove(path.size() - 1);
        }
    }
}
