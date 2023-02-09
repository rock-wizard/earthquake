package leetcode;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class CombinationSum {
    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        List<List<Integer>> ans = new ArrayList<>();
        List<Integer> combination = new ArrayList<>();
        Arrays.sort(candidates);
        dfs(candidates, 0, target, ans, combination);
        return ans;
    }

    private void dfs(int[] candidates, int begin, int target, List<List<Integer>> ans, List<Integer> combination) {
        if (target == 0) {
            ans.add(new ArrayList<>(combination));
            return;
        }

        for (int i = begin; i < candidates.length; i++) {
            if (target - candidates[i] < 0) {
                return;
            }
            combination.add(candidates[i]);
            dfs(candidates, i, target - candidates[i], ans, combination);
            combination.remove(combination.size() - 1);
        }
    }
}
