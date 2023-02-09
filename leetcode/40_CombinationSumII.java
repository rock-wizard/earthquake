package leetcode;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class CombinationSumII {
    public List<List<Integer>> combinationSum2(int[] candidates, int target) {
        List<List<Integer>> ans = new ArrayList<>();
        List<Integer> combination = new ArrayList<>();
        Arrays.sort(candidates);
        dfs(candidates, target, 0, ans, combination);
        return ans;
    }

    private void dfs(int[] candidates, int target, int begin, List<List<Integer>> ans, List<Integer> combination) {
        if (target == 0) {
            ans.add(new ArrayList(combination));
            return;
        }

        for (int i = begin; i < candidates.length; i++) {
            if (target - candidates[i] < 0) {
                return;
            }
            combination.add(candidates[i]);
            dfs(candidates, target - candidates[i], i + 1, ans, combination);
            combination.remove(combination.size() - 1);
            while (i < candidates.length - 1 && candidates[i] == candidates[i + 1]) {
                i++;
            }
        }
    }
}
